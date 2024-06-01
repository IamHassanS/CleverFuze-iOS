//
//  CFDeliveryDetailController.swift
//  CleverFuze
//
//  Created by AnilKumar on 31/08/22.
//

import Foundation


class CFDeliveryDetailController: CFBaseEntryController {
    var valued: Bool?
    var viewCustomerData: CFFieldDataLoder = [:]
    override var screenType: CFScreenType?{
        didSet{
            if screenType == .view{
                viewCustomerData = [0: [.deliveryDate,.customerName,.deliveryType,.deliveryAddress,.deliveryZone,.propertyWeight,.staffName(0),.damagaeMissingItems,.fileInput(0),.deliveryoutRate,.releaseIncome]]
            }else if screenType == .edit{
                viewCustomerData = [0: [.customerName,.deliveryType,.deliveryAddress,.deliveryDate,.deliveryZone,.propertyWeight,.deliveryoutRate,.releaseIncome,.damagaeMissingItems,.staffName(0)]]
            }else if screenType == .add{
                viewCustomerData = [0: [.customerName,.deliveryType,.deliveryAddress,.deliveryDate,.deliveryZone,.propertyWeight,.deliveryoutRate,.releaseIncome,.damagaeMissingItems,.staffName(0)]]
            }
            self.loadingData = self.viewCustomerData
            self.setDataValues()
            if screenType == .edit{
                valued = true
            }
        }
    }
    override init() {
        super.init()
        self.loadingData = self.viewCustomerData
    }
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        if field == .damagaeMissingItems, let dataSource = data as? CFDropDownValue {
            self.existLoadedData?[field] = data
            self.validateDamagaeMissingItems(dataSource)
            self.delegate?.apiSucess()
            super.didSetValue(data, indexPath: indexPath, field: field)
        } else if field == .deliveryType, let dataSource = data as? CFDropDownDataSource {
            self.editLoadedData?[.deliveryType] = dataSource.id
            super.didSetValue(data, indexPath: indexPath, field: field)
            checkAndCallAPI()
        } else if field == .customerName, let dataSource = data as? CFDropDownDataSource {
            self.editLoadedData?[.customerName] = dataSource.customerID
            super.didSetValue(data, indexPath: indexPath, field: field)
            checkAndCallAPI()
        } else {
            super.didSetValue(data, indexPath: indexPath, field: field)
        }
    }

    private func checkAndCallAPI() {
        startLoadingIndicator()
        var customerName = self.editLoadedData?[.customerName]
        if customerName == nil {
            customerName = self.existData?.customerID
        }
        if let deliveryType = self.editLoadedData?[.deliveryType] as? Int, deliveryType == 1 {
            fetchActualWeight(postBody: ["customer_id": "\(customerName ?? "")" , "delivery_type" : "\(deliveryType)"]) { weight in
                self.existLoadedData?[.propertyWeight] = weight
                self.delegate?.apiSucess()
            }
        } else {
            self.existLoadedData?[.propertyWeight] = ""
            self.delegate?.apiSucess()
        }
        self.fieldEditable(.propertyWeight)
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
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Delivery Release")
        }else if buttonType == .addMoreStaffs{
            self.addMoreStaff()
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .some(.edit):
            return .updateDelivery(id: self.existData?.id ?? 0)
        case .some(.add):
            return .addDelivery
        case .some(.delete):
            return .deleteDelivery(id: self.existData?.id ?? 0)
        default:
            return nil
        }
    }
    
    override func postBody() -> [String: Any]{
        var params = [String: Any]()
        
        if let damageMissing = self.existLoadedData?[.damagaeMissingItems] as? CFDropDownValue {
            params["damage_missing"] = damageMissing.id ?? 0
        }
        
        if let deliveryZoneValue = self.existLoadedData?[.deliveryZone] as? CFDropDownReleaseType {
            params["delivery_zone"] = deliveryZoneValue.id ?? 0
        }
        params["delivery_date"] = self.existLoadedData?[.deliveryDate] as? String ?? ""
        params["deliveryout_rate"] = self.existLoadedData?[.deliveryoutRate] as? String ?? ""
        
        if let customerNameValue = self.existLoadedData?[.customerName] as? CFDropDownValue {
            params["customer_id"] = customerNameValue.customerID ?? 0
        } else {
            params["customer_id"] = self.existData?.customerID ?? 0
        }
        
        params["release_income"] = self.existLoadedData?[.releaseIncome] as? String ?? ""
        params["delivery_address"] = self.existLoadedData?[.deliveryAddress] as? String ?? ""
        params["property_weight"] = self.existLoadedData?[.propertyWeight] as? String ?? ""
        
        if let deliveryTypeValue = self.existLoadedData?[.deliveryType] as? CFDropDownReleaseType {
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
                staffNames.append(staffName)
            } else {
                break
            }
        }

        params["staff_name"] = staffNames
        
        print(params)
        return params
    }
    
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        super.setDataValues(.buttonFooter(.double(left: .addMoreStaffs, right: .submit)))
    }
    open override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        var editable = false
        var grayOut = false
        switch field {

        case .deliveryDate where self.screenType == .view ||  StrongboxController.userData?.userRole == .manager:
                      editable = false
        case .customerName where self.screenType == .view || self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            return (editable: false, grayOut: true)
        case .customerName where self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            editable = false
            grayOut = true
        case .deliveryType where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .deliveryType where self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            return (editable: false, grayOut: true)
        case .deliveryAddress where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .deliveryZone where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .propertyWeight where self.screenType == .add || self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            if let loadedData = self.existLoadedData, let propertyWeight = loadedData[.deliveryType] as? CFDropDownDataSource, propertyWeight.id == 1  {
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
        case .deliveryoutRate where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        case .releaseIncome where self.screenType == .view || StrongboxController.userData?.userRole == .manager:
                       editable = false
        default:
            editable = self.screenType?.isEditable ?? true
        }
        return (editable, grayOut)
    }
}

struct FullPartialResponse: Codable {
    let actualweight: String
    let employeeList: [String]
    let status: String
    let testArray: [String]

    enum CodingKeys: String, CodingKey {
        case actualweight
        case employeeList = "employee_list"
        case status
        case testArray = "test_array"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actualweight = try container.decode(String.self, forKey: .actualweight)
        self.employeeList = try container.decode([String].self, forKey: .employeeList)
        self.status = try container.decode(String.self, forKey: .status)
        self.testArray = try container.decode([String].self, forKey: .testArray)
    }
}


