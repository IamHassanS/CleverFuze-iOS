//
//  CFDockDetailController.swift
//  CleverFuze
//
//  Created by AnilKumar on 01/09/22.
//

import UIKit

class CFDockDetailController: CFBaseEntryController, CFDockDetailControllerDelegate {
    
    func didReceiveDocumentData(_ documentData: Int?, _ completion: @escaping (Bool) -> Void) {
        let conditionsSatisfied = true
        completion(conditionsSatisfied)
    }
    
    var valued: Bool?
    var viewCustomerData: CFFieldDataLoder = [:]
    var userDocumentData: Int?
    lazy var totalRecordListView: CFTotalRecordListView! =  CFTotalRecordListView()
    override var screenType: CFScreenType?{
        didSet{
            if self.screenType == .view{
                var customerData: [CFCustomFieldType] = [.releaseDate(.view), .customerName, .releasetype, .companyName, .pickupCompany, .releaseWeight, .staffName(0), .damagaeMissingItems, .fileInput(0), .handlingoutFee, .releaseIncome,
                ]
                
                let value = self.loadingData[0] ?? []
                let index = value.firstIndex(where: {$0 == .fileInput(1)})

                self.viewCustomerData = [0: customerData]
                
            }else if self.screenType == .edit{
                self.viewCustomerData = [0: [.customerName,.releasetype,.companyAndOrganization,.pickupCompany,.releaseWeight,.releaseDate(.edit),.damagaeMissingItems,.handlingoutFee,.releaseIncome,.staffName(0)]]
            }else if self.screenType == .add{
                self.viewCustomerData = [0: [.customerName,.releasetype,.companyAndOrganization,.pickupCompany,.releaseWeight,.releaseDate(.add),.damagaeMissingItems,.handlingoutFee,.releaseIncome,.staffName(0)]]
            }
            
            self.loadingData = self.viewCustomerData
            self.setDataValues()
            if self.screenType == .edit{
                self.valued = true
            }
        }
    }
    override init() {
        super.init()
        self.totalRecordListView.delegateDamageitem = self
        self.loadingData = self.viewCustomerData
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Dock Release")
        }else if buttonType == .addMoreStaffs{
            self.addMoreStaff()
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .some(.edit):
            return .updateDock(id: self.existData?.id ?? 0)
        case .some(.add):
            return .addDock
        case .some(.delete):
            return .deleteDock(id: self.existData?.id ?? 0)
        default:
            return nil
        }
    }
    
    override func postBody() -> [String: Any]{
        
        var params = [String: Any]()
        
        if let damageMissing = self.existLoadedData?[.damagaeMissingItems] as? CFDropDownValue {
            params["damage_missing"] = damageMissing.id ?? 0
        }
        
        if let damageMissing = self.existLoadedData?[.companyAndOrganization] as? CFDropDownCompany {
            params["company_id"] = damageMissing.id ?? 0
        }
        
        if let customerNameValue = self.existLoadedData?[.customerName] as? CFDropDownValue {
            params["customer_id"] = customerNameValue.customerID ?? 0
        } else {
            params["customer_id"] = self.existData?.customerID ?? 0
        }
        
        if let deliveryTypeValue = self.existLoadedData?[.releasetype] as? CFDropDownReleaseType {
            params["delivery_type"] = deliveryTypeValue.id ?? 0
        }
        
        if let documentPath = UserDefaults.saveUserDocument {
            if let fileData = try? Data(contentsOf: URL(fileURLWithPath: documentPath)){
                params["missingFile"] = fileData
            }
        }else if let documentPath = UserDefaults.saveUserDocument{
            if let fileData = try? Data(contentsOf: URL(fileURLWithPath: documentPath)){
                params["missingFile"] = fileData
            }
        }

        var staffNames: [String] = []

        for i in 0..<Int.max {
            let staffNameKey = CFCustomFieldType.staffName(i)
            if let staffName = self.existLoadedData?[staffNameKey] as? String {
                let sanitizedStaffName = sanitizeStaffName(staffName)
                staffNames.append(sanitizedStaffName)
            } else {
                break
            }
        }

        params["staff_name"] = staffNames
        
        params["release_income"] = self.existLoadedData?[.releaseIncome] as? String ?? ""
        params["release_date"] = self.existLoadedData?[.releaseDate(self.screenType)] as? String ?? ""
        params["property_weight"] = self.existLoadedData?[.releaseWeight] as? String ?? ""
        params["company_pickup"] = self.existLoadedData?[.pickupCompany] as? String ?? ""
        params["handlingout_fee"] = self.existLoadedData?[.handlingoutFee] as? String ?? ""
        
        print(params)
        return params
        
    }
    
    func sanitizeStaffName(_ staffName: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        return staffName.components(separatedBy: allowedCharacters.inverted).joined()
    }
    
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        super.setDataValues(.buttonFooter(.double(left: .addMoreStaffs, right: .submit)))
    }
    
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        if field == .damagaeMissingItems, let dataSource = data as? CFDropDownValue{
            self.existLoadedData?[field] = data
            self.validateDamagaeMissingItems(dataSource)
            self.delegate?.apiSucess()
            super.didSetValue(data, indexPath: indexPath, field: field)
        } else if field == .releasetype, let dataSource = data as? CFDropDownDataSource {
            self.editLoadedData?[.releasetype] = dataSource.id
            super.didSetValue(data, indexPath: indexPath, field: field)
            checkAndCallAPI()
        } else if field == .customerName, let dataSource = data as? CFDropDownDataSource {
            self.editLoadedData?[.customerName] = dataSource.customerID
            super.didSetValue(data, indexPath: indexPath, field: field)
            checkAndCallAPI()
        }else{
            super.didSetValue(data, indexPath: indexPath, field: field)
        }
    }
    
    private func checkAndCallAPI() {
        startLoadingIndicator()
        var customerName = self.editLoadedData?[.customerName]
        if customerName == nil {
            customerName = self.existData?.customerID
        }
        if let deliveryType = self.editLoadedData?[.releasetype] as? Int, deliveryType == 1 {
            fetchActualWeight(postBody: ["customer_id": "\(customerName ?? "")" , "delivery_type" : "\(deliveryType)"]) { weight in
                self.existLoadedData?[.releaseWeight] = weight
                self.delegate?.apiSucess()
            }
        } else {
            self.existLoadedData?[.releaseWeight] = ""
            self.delegate?.apiSucess()
        }
        self.fieldEditable(.releaseWeight)
    }
    
    func fetchActualWeight(postBody: [String: String]? = nil, completion: @escaping (String) -> Void) {
        CFCommunicationController.networkRequest(endPoint: .fullAndPartial,requestMethod: .get, params: postBody) { (data, _, _) in
            guard let data = data else {
                completion("")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(FullPartialResponse.self, from: data)
                completion(decodedData.actualweight)
            } catch {
                completion("")
            }
        }
    }
    
    open override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        var editable = false
        var grayOut = false
        switch field {

        case .releaseDate where self.screenType == .view ||  StrongboxController.userData?.userRole == .manager:
                      editable = false
        case .fileInput(let value) where self.screenType == .view ||  StrongboxController.userData?.userRole == .manager:
                      grayOut = true
                      editable = false
        case .customerName where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
            editable = false
            grayOut = true
        case .releasetype where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .companyName where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .pickupCompany where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .releaseWeight where self.screenType == .add || self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            if let loadedData = self.existLoadedData, let propertyWeight = loadedData[.releasetype] as? CFDropDownDataSource, propertyWeight.id == 1 {
                editable = false
                grayOut = true
            } else {
                editable = true
                grayOut = false
            }
        case .staffName where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .damagaeMissingItems where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .handlingoutFee where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .releaseIncome where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        default:
            editable = self.screenType?.isEditable ?? true
        }
        return (editable, grayOut)
    }
}

