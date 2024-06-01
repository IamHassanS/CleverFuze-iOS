//
//  CFViewCustomerController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFViewCustomerDetailController: CFBaseEntryController {
    var documentShowValue: Bool = false
    var viewCustomerData: CFFieldDataLoder = [:]
    var valued: Bool?
    var prepopulatedDocumentCount: Int = 0
    override var screenType: CFScreenType?{
        didSet{
//        MARK: Below changes for to remove estimated weight and estimated income (Add, edit , view) :
            if screenType == .view{
                viewCustomerData = [0: [.customerDetails, .namesz,.customerType(nil), .warehouse(nil), .lotnumberz, .packedDateInz, .loadDatez, .estimatedDateOutz,.actualDateOutz, .intialActualWightz,.actualWeightz, .totalRateInz, .zonez, .storageRatez,.customerRealesz]]
            }else if screenType == .edit{
                viewCustomerData = [0: [.customerDetails, .customerType(.edit), .name,.customerstatus,.releaseDate(.edit), .propertyAddress, .addressLine2, .city, .state, .zipcode],
                                    1: [.propertyDetails, .propertyLocation(.edit), .lotNumber, .loadDate, .packDateIn, .estimatedDateOut, .initialActualWeight,.actualWeight, .zone, .totalRateIn, .storageRate, .totalHandling, .expectedMonthsInStorage, .overflow, .storageVaults, .liftVans, .warehouse(.edit), .companyAndOrganization, .actualIncome, .initialStorage, .quarterlyStorage, .totalIncome,.currentStorage],
                                    2: [.documentDetails, .documentToUpload(0),.fileInput(0)]]
            }else if screenType == .add{
                viewCustomerData = [0: [.customerDetails, .customerType(.edit), .name,.propertyAddress, .addressLine2, .city, .state, .zipcode],
                                    1: [.propertyDetails, .propertyLocation(.edit), .lotNumber, .loadDate, .packDateIn, .estimatedDateOut, .initialActualWeight,.actualWeight, .zone, .totalRateIn, .storageRate, .totalHandling, .expectedMonthsInStorage, .overflow, .storageVaults, .liftVans, .warehouse(.edit), .companyAndOrganization, .actualIncome, .initialStorage, .quarterlyStorage, .totalIncome,.currentStorage],
                                    2: [.documentDetails, .documentToUpload(0),.fileInput(0)]]
            }else{
                
                viewCustomerData = [0: [.customerDetails, .customerType(nil), .name, .propertyAddress, .addressLine2, .city, .state, .zipcode],
                                    1: [.propertyDetails, .propertyLocation(nil), .lotNumber, .packDateIn, .loadDate, .estimatedDateOut, .initialActualWeight, .actualWeight, .zone, .totalRateIn, .storageRate, .totalHandling, .expectedMonthsInStorage, .overflow, .storageVaults, .liftVans, .warehouse(.edit), .companyAndOrganization, .actualIncome, .initialStorage, .quarterlyStorage, .totalIncome,.currentStorage],
                                    2: [.documentDetails, .documentToUpload(0),.fileInput(0)]]
           }
            
            if screenType == .edit, let customerRelease = (existData as? CFRecordDatum)?.customerRelease, customerRelease == "No Release" {
                
                print(customerRelease)
                // Modify the fields for the .edit screenType
                viewCustomerData[0]?.removeAll { $0 == .customerstatus || $0 == .releaseDate(.edit) }
            }
            
            if screenType == .edit, let documentList = (existData as? CFRecordDatum)?.documentListCollection, !documentList.isEmpty {

                viewCustomerData[2]?.removeAll(where: { $0 == .documentToUpload(0) || $0 == .fileInput(0) })
                
                for (index, _) in documentList.enumerated() {
                    viewCustomerData[2]?.append(.documentToUpload(index))
                    viewCustomerData[2]?.append(.fileInput(index))
                }
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
    func currentStorageFetch(){
        startLoadingIndicator()
        if let dropdownData = self.existLoadedData?[.warehouse(.edit)] as? CFDropDownDataSource,
           let dropdownValue = dropdownData as? CFDropDownValue,
           let id = dropdownValue.id {
            print("ID: \(id)")
            self.fetchCurrentStorage(postBody: ["warehouse_id": "\(id)"]) { weight in
                self.delegate?.apiSucess()
                self.existLoadedData?[.currentStorage] = weight
            }
        }
    }
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        super.didSetValue(data, indexPath: indexPath, field: field)
        if field == .totalRateIn{
            guard let estimatedWeight = field == .totalRateIn ? self.existLoadedData?[.estimatedWeight] as? String : data as? String,
                  let doubleEstimatedWeight = Double(estimatedWeight),
                  let totalRateIn = field == .estimatedWeight ? self.existLoadedData?[.totalRateIn] as? String :  data as? String,
                  let doubleTotalRateIn = Double(totalRateIn) else{
                return
            }
            self.existLoadedData?[.estimatedIncome] = String(doubleTotalRateIn / doubleEstimatedWeight).addDecimal
            self.delegate?.apiSucess()
        } else if field == .warehouse(.edit) {
          currentStorageFetch()
        }
    }
    
    override func setValues() {
        super.setValues()
        if let documentList = (existData as? CFRecordDatum)?.documentListCollection {
            prepopulatedDocumentCount = documentList.count
        }
    }
    
    func fetchCurrentStorage(postBody: [String: String]? = nil, completion: @escaping (String) -> Void) {
        CFCommunicationController.networkRequest(endPoint: .warehouseCalc,requestMethod: .get, params: postBody) { (data, _, _) in
            guard let data = data else {
                completion("")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(WarehouseCurrentStorageDatum.self, from: data)
                completion(decodedData.currentStorage)
            } catch {
                completion("")
            }
        }
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Customer")
            
        }else if buttonType == .addMoreFile{
            self.addMoreFile()
            self.delegate?.apiSucess()
        }else{
            debugPrint("nothiong to validate the condition")
        }
    }
            
    override func endPoint() -> CFEndPoint{
        switch self.screenType{
        case .delete:
            return .deleteCustomer(id: self.existData?.customerID ?? 1)
        case .some(.edit):
            return .updateCustomer(id: self.existData?.customerID ?? 1)
        case .some(.add):
            return .addCustomer
        default:
            return .viewCustomer
        }
    }
    
    override func postBody() -> [String: Any]?{
        var params = [String: Any]()
        self.existLoadedData.forEach { (field, value) in
            guard let key = field.keysForCustomer else{
                return
            }
            if let url = value as? URL, let data = try? Data(contentsOf: URL(fileURLWithPath: url.path)){
                params[key] = data
            }else if let id = (value as? CFDropDownDataSource)?.id{
                params[key] =  id
            }else{
                params[key] = (value as? CFDropDownDataSource)?.name ?? (value as? String ?? "")
            }
        }
        params.forEach { (key, value) in
            print("\(key): \(value)")
        }
        return params
    }
    
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        guard let screenType = self.screenType, let userRole = StrongboxController.userData?.userRole else { return  }
        switch (screenType, userRole){
        case (.view, .admin):
            self.addTheFieldsInLast(.buttonFooter(.double(left: .edit, right: .delete)))
        case (.edit, .admin), (.add, .admin), (.add, .manager), (.edit, .manager):
            self.addTheFieldsInLast(.buttonFooter(.double(left: .addMoreFile, right: .submit)))
        case (.view, .manager):
            self.addTheFieldsInLast(.buttonFooter(.single(.edit)))
        default:
            break
        }
    }
    
    override func didSelectedTheRemove(_ fieldType: CFCustomFieldType?) {
        super.didSelectedTheRemove(fieldType)
        guard case .fileInput(let id) = fieldType else{
            return
        }
        super.didSelectedTheRemove(.documentToUpload(id))
    }
    
    override func remove(at key: Int, in index: Int) {
        super.remove(at: key, in: index)
        self.viewCustomerData[key]?.remove(at: index)
    }
    
    override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        let customerRelease = (existData as? CFRecordDatum)?.customerRelease

        switch field {
        case .fileInput(let index), .documentToUpload(let index):
            if index < prepopulatedDocumentCount {
                return (editable: false, grayOut: true)
            } else {
                return (editable: true, grayOut: false)
            }
        case .customerstatus where self.screenType == .edit || StrongboxController.userData?.userRole == .manager,
             .releaseDate(.edit) where self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
            if customerRelease == "Partial Released" || customerRelease == "Released" {
                return (editable: false, grayOut: true)
            } else {
                return (editable: true, grayOut: false)
            }
        case .currentStorage where self.screenType == .add || StrongboxController.userData?.userRole == .manager:
            return (editable: false, grayOut: true)
        default:
            return super.fieldEditable(field)
        }
    }
}

extension CFViewCustomerDetailController{
    
    func addMoreFile(){
        
        var value = viewCustomerData[2] ?? []
        let count = value.filter{ $0.title == CFCustomFieldType.fileInput(0).title}.count
        let index = value.lastIndex{ $0.uniqueValue == CFCustomFieldType.fileInput(count - 1).uniqueValue} ?? 0
        value.insert(.documentToUpload(count), at: 1 + index)
        value.insert(.fileInput(count), at: 2 + index)
        viewCustomerData[2] = value
        self.loadingData = self.viewCustomerData
        self.setDataValues()
        
    }
    
}
