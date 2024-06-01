//
//  CFRecordDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

// MARK: - CFRecordDatum
struct CFRecordDatum: Codable {
    let custID, custType, id: Int?
    let name: String?
    let customerType: CFQuantumValue?
    let address: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip, createdAt, updatedAt: String?
    let deletedAt: String?
    let customerID: Int?
    let propertyLocation: String?
    let customerstatus:String?
    let releaseDate:String?
    let storageValues, liftWanes: Int?
    let overflow: String?
    let initialActualweight: Int?
    let lotnumber, packdateIn,actualdateout,expecteddateOut: String?
    let estimatedweight : String?
    let actualweight:Int?
    let loadDate: String?
    let zone: String?
    let totalinRate: Int?
    let handlingIn: Int?
    let storagerate: Double?
    let customerWarehouse: CFQuantumValue?
    let customerCompany: CFQuantumValue?
    let expectedmonthsStorage: Int?
    let estimatedincome, actualincome, initialstorage: Double?
    let totalIncome: String?
    let currentstorage: Int?
    let zoneCaption: String?
    let custWarehouse: String?
    
    // #MARK: Value for view customer
    let customerReleaseDate: String?
    let customerRelease: String?
    let updateURL, deleteURL: String?
    let documentLists: [String]?
    let documentListCollection: [DocumentListCollection]?
    
    // #MARK: Value for view report
    let dockCustomer: String?
    let dockID, deliveryID: String?
    let deliveryCustomer, dockReleaseType, deliveryReleaseType: String?
    let customerIncome: Int?
    let initialStorageIncome, quarterlyStorageIncome: Double?
    let releaseType, releasedWeight, releasedDate: String?
    let outRate, outRateCap: String?
    let quarterStorageIncome: String?
    let storageIncome, storageReleaseIncome: String?
    let action: String?
    
    enum CodingKeys: String, CodingKey {
        case custID = "cust_id"
        case custType = "cust_type"
        case id, name
        case customerType = "customer_type"
        case address, address2, city, state, zip
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case customerID = "customer_id"
        case propertyLocation = "property_location"
        case customerstatus = "customer_status"
        case releaseDate = "Release Date:"
        case storageValues = "storage_values"
        case liftWanes = "lift_wanes"
        case overflow
        case initialActualweight = "initial_actualweight"
        case lotnumber
        case packdateIn = "packdate_in"
        case actualdateout = "actualdate_out"
        case expecteddateOut = "expecteddate_out"
        case estimatedweight, actualweight
        case loadDate = "load_date"
        case zone
        case totalinRate = "totalin_rate"
        case handlingIn = "handling_in"
        case storagerate
        case customerWarehouse = "customer_warehouse"
        case customerCompany = "customer_company"
        case expectedmonthsStorage = "expectedmonths_storage"
        case estimatedincome, actualincome, initialstorage, currentstorage
        case totalIncome = "total_income"
        case zoneCaption = "zone_caption"
        case custWarehouse = "cust_warehouse"
        
        // #MARK: Value for view customer
        case customerReleaseDate = "customer_release_date"
        case customerRelease = "customer_release"
        case updateURL = "update_url"
        case deleteURL = "delete_url"
        case documentLists
        case documentListCollection
        
        // #MARK: Value for view report
        case dockCustomer = "dock_customer"
        case dockID = "dock_id"
        case deliveryID = "delivery_id"
        case deliveryCustomer = "delivery_customer"
        case dockReleaseType = "dock_release_type"
        case deliveryReleaseType = "delivery_release_type"
        case customerIncome = "customer_income"
        case initialStorageIncome = "initial_storage_income"
        case quarterlyStorageIncome = "quarterly_storage_income"
        case releaseType = "release_type"
        case releasedWeight = "released_weight"
        case releasedDate = "released_date"
        case outRate = "out_rate"
        case outRateCap = "out_rate_cap"
        case quarterStorageIncome = "quarter_storage_income"
        case storageIncome = "storage_income"
        case storageReleaseIncome = "storage_release_income"
        case action
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.custID = try? container?.decodeIfPresent(Int.self, forKey: .custID)
        self.custType = try? container?.decodeIfPresent(Int.self, forKey: .custType)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.customerType = try? container?.decodeIfPresent(CFQuantumValue.self, forKey: .customerType)
        self.address = try? container?.decodeIfPresent(String.self, forKey: .address)
        self.address2 = try? container?.decodeIfPresent(String.self, forKey: .address2)
        self.city = try? container?.decodeIfPresent(String.self, forKey: .city)
        self.state = try? container?.decodeIfPresent(String.self, forKey: .state)
        self.zip = try? container?.decodeIfPresent(String.self, forKey: .zip)
        self.createdAt = try? container?.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? container?.decodeIfPresent(String.self, forKey: .updatedAt)
        self.deletedAt = try? container?.decodeIfPresent(String.self, forKey: .deletedAt)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
        self.propertyLocation = try? container?.decodeIfPresent(String.self, forKey: .propertyLocation)
        self.customerstatus = try? container?.decodeIfPresent(String.self, forKey: .customerstatus)
        self.releaseDate = try? container?.decodeIfPresent(String.self, forKey: .releaseDate )
        self.storageValues = try? container?.decodeIfPresent(Int.self, forKey: .storageValues)
        self.liftWanes = try? container?.decodeIfPresent(Int.self, forKey: .liftWanes)
        self.overflow = try? container?.decodeIfPresent(String.self, forKey: .overflow)
        self.initialActualweight = try? container?.decodeIfPresent(Int.self, forKey: .initialActualweight)
        self.lotnumber = try? container?.decodeIfPresent(String.self, forKey: .lotnumber)
        self.packdateIn = try? container?.decodeIfPresent(String.self, forKey: .packdateIn)
        self.actualdateout = try? container?.decodeIfPresent(String.self, forKey: .actualdateout)
        self.expecteddateOut = try? container?.decodeIfPresent(String.self, forKey: .expecteddateOut)
        self.estimatedweight = try? container?.decodeIfPresent(String.self, forKey: .estimatedweight)
        self.actualweight = try? container?.decodeIfPresent(Int.self, forKey: .actualweight)
        self.loadDate = try? container?.decodeIfPresent(String.self, forKey: .loadDate)
        self.zone = try? container?.decodeIfPresent(String.self, forKey: .zone)
        self.totalinRate = try? container?.decodeIfPresent(Int.self, forKey: .totalinRate)
        self.handlingIn = try? container?.decodeIfPresent(Int.self, forKey: .handlingIn)
        self.storagerate = try? container?.decodeIfPresent(Double.self, forKey: .storagerate)
        self.customerWarehouse = try? container?.decodeIfPresent(CFQuantumValue.self, forKey: .customerWarehouse)
        self.customerCompany = try? container?.decodeIfPresent(CFQuantumValue.self, forKey: .customerCompany)
        self.expectedmonthsStorage = try? container?.decodeIfPresent(Int.self, forKey: .expectedmonthsStorage)
        self.estimatedincome = try? container?.decodeIfPresent(Double.self, forKey: .estimatedincome)
        self.actualincome = try? container?.decodeIfPresent(Double.self, forKey: .actualincome)
        self.initialstorage = try? container?.decodeIfPresent(Double.self, forKey: .initialstorage)
//        self.quarterlystorage = try? container?.decodeIfPresent(Double.self, forKey: .quarterlystorage)
        self.currentstorage = try? container?.decodeIfPresent(Int.self, forKey: .currentstorage)
        self.totalIncome = try? container?.decodeIfPresent(String.self, forKey: .totalIncome)
        self.zoneCaption = try? container?.decodeIfPresent(String.self, forKey: .zoneCaption)
        self.custWarehouse = try? container?.decodeIfPresent(String.self, forKey: .custWarehouse)
      
        // #MARK: Value for view customer
        self.customerReleaseDate = try? container?.decodeIfPresent(String.self, forKey: .customerReleaseDate)
        self.customerRelease = try? container?.decodeIfPresent(String.self, forKey: .customerRelease)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.deleteURL = try? container?.decodeIfPresent(String.self, forKey: .deleteURL)
        self.documentLists = try? container?.decodeIfPresent([String].self, forKey: .documentLists)
        self.documentListCollection = try? container?.decodeIfPresent([DocumentListCollection].self, forKey: .documentListCollection)

        // #MARK: Value for view report
        self.dockCustomer = try? container?.decodeIfPresent(String.self, forKey: .dockCustomer)
        self.dockID = try? container?.decodeIfPresent(String.self, forKey: .dockID)
        self.deliveryID = try? container?.decodeIfPresent(String.self, forKey: .deliveryID)
        self.deliveryCustomer = try? container?.decodeIfPresent(String.self, forKey: .deliveryCustomer)
        self.dockReleaseType = try? container?.decodeIfPresent(String.self, forKey: .dockReleaseType)
        self.deliveryReleaseType = try? container?.decodeIfPresent(String.self, forKey: .deliveryReleaseType)
        self.customerIncome = try? container?.decodeIfPresent(Int.self, forKey: .customerIncome)
        self.initialStorageIncome = try? container?.decodeIfPresent(Double.self, forKey: .initialStorageIncome)
        self.quarterlyStorageIncome = try? container?.decodeIfPresent(Double.self, forKey: .quarterlyStorageIncome)
        self.releaseType = try? container?.decodeIfPresent(String.self, forKey: .releaseType)
        self.releasedWeight = try? container?.decodeIfPresent(String.self, forKey: .releasedWeight)
        self.releasedDate = try? container?.decodeIfPresent(String.self, forKey: .releasedDate)
        self.outRate = try? container?.decodeIfPresent(String.self, forKey: .outRate)
        self.outRateCap = try? container?.decodeIfPresent(String.self, forKey: .outRateCap)
        self.quarterStorageIncome = try? container?.decodeIfPresent(String.self, forKey: .quarterStorageIncome)
        self.storageIncome = try? container?.decodeIfPresent(String.self, forKey: .storageIncome)
        self.storageReleaseIncome = try? container?.decodeIfPresent(String.self, forKey: .storageReleaseIncome)
        self.action = try? container?.decodeIfPresent(String.self, forKey: .action)
    }
    
}

struct DocumentListCollection: Codable {
    let document: String
    let documentType: String
}

extension CFRecordDatum: CFRecordDataSource{
    
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType: Any]{
        
        var dataValue = [CFCustomFieldType: Any]()
        
        for field in fields{
            switch field {
            case .customerType,.customertypsz:
                dataValue[field] = CFDropDownController.dropDownValues?.customerTypes?.filter{$0.id == self.customerType?.intValue || $0.name?.lowercased() == self.customerType?.stringValue.lowercased()}.first
            case .name,.namesz:
                dataValue[field] = self.name
            case .propertyAddress:
                dataValue[field] = self.address
            case .addressLine2:
                dataValue[field] = self.address2
            case .city:
                dataValue[field] = self.city
            case .state:
                dataValue[field] = CFDropDownController.dropDownValues?.states?.filter{$0.name?.lowercased() == self.state?.lowercased()}.first
            case .zipcode:
                dataValue[field] = self.zip
            case .propertyLocation:
                dataValue[field] = self.propertyLocation
//            case .customerzone:
//                dataValue[field] = self.zone
            case .releaseWeight:
                dataValue[field] = self.releasedWeight
            case .customerstatus:
                dataValue[field] = self.customerRelease
            case .customerRelease,.customerRealesz:
                dataValue[field] =  self.customerRelease
            case .releaseDate:
                dataValue[field] = self.releasedDate
            case .releasetype:
                dataValue[field] = CFDropDownController.dropDownValues?.releaseType?.filter{$0.name == self.releaseType}.first
            case .lotNumber,.lotnumberz:
                dataValue[field] = self.lotnumber
            case .loadDate,.loadDatez:
                dataValue[field] = self.loadDate
            case .packDateIn,.packedDateInz:
                dataValue[field] = self.packdateIn
            case .actualdateout,.actualDateOutz:
                dataValue[field] = self.actualdateout ?? self.customerReleaseDate
            case .estimatedDateOut,.estimatedDateOutz:
                dataValue[field] = self.expecteddateOut
            case .estimatedWeight:
                dataValue[field] =  self.estimatedweight
            case .initialActualWeight,.intialActualWightz:
                dataValue[field] = String(self.initialActualweight ?? 0)
            case .actualWeight,.actualWeightz:
                dataValue[field] = String(self.actualweight ?? 0)
            case .zone,.zonez:
                dataValue[field] = self.zone
            case .customerzone:
                dataValue[field] = self.zone
//            case .ZoNe:
//                dataValue[field] = self.zone
//            case .zone:
//                dataValue[field] = CFDropDownController.dropDownValues?.zoneTypes?.filter{$0.name?.lowercased() == self.zone?.lowercased() || (String($0.id ?? 0) == self.zone)}.first
            case .totalRateIn,.totalRateInz:
                dataValue[field] = String(self.totalinRate ?? 0)
            case .storageRate,.storageRatez:
                dataValue[field] = String(self.storagerate ?? 0)
            case .totalHandling:
                dataValue[field] = String(self.handlingIn ?? 0)
            case .expectedMonthsInStorage:
                dataValue[field] = String(self.expectedmonthsStorage ?? 0)
            case .overflow:
                dataValue[field] = self.overflow
            case .storageVaults:
                dataValue[field] = String(self.storageValues ?? 0)
            case .liftVans:
                dataValue[field] = String(self.liftWanes ?? 0)
            case.totalIncome:
                dataValue[field] = String(self.customerIncome ?? 0)
            case .warehouse:
                let customerWarehouse = CFDropDownController.dropDownValues?.warehouse?.filter{$0.id == self.customerWarehouse?.intValue || $0.name?.lowercased() == self.customerWarehouse?.stringValue.lowercased()}.first
                let custWarehouse = CFDropDownController.dropDownValues?.warehouse?.filter{$0.name?.lowercased() == self.custWarehouse?.lowercased()}.first
                dataValue[field] = customerWarehouse ?? custWarehouse ?? self.custWarehouse ?? self.customerWarehouse?.stringValue
            case .companyAndOrganization:
                dataValue[field] = CFDropDownController.dropDownValues?.company?.filter{$0.id == self.customerCompany?.intValue || $0.name?.lowercased() == self.customerCompany?.stringValue.lowercased()}.first
            case .estimatedIncome:
                dataValue[field] = String(self.estimatedincome ?? 0)
            case .actualIncome:
                dataValue[field] = String(self.actualincome ?? 0)
                
            case .initialStorage:
                dataValue[field] = String(self.initialStorageIncome ?? 0)
            case .totalincomv:
                dataValue[field] = self.totalIncome
            case .currentStorage:
                dataValue[field] = self.currentstorage
            case .releaseStatus:
                dataValue[field] = self.customerRelease
            case .StorageReleaseIncome:
                dataValue[field] =  self.storageReleaseIncome
            case.quarterlyStorage:
                dataValue[field] = String(self.quarterlyStorageIncome ?? 0)
            case .customerName:
                dataValue[field] = CFDropDownController.dropDownValues?.customers?.filter {
                    $0.name?.lowercased() == self.name?.lowercased() || $0.id == self.custID
                }.first ?? self.name
            case .fileInput(let index):
                if let documentList = self.documentListCollection, index < documentList.count {
                    dataValue[field] = documentList[index].document
                } else {
                    break
                }
            case .documentToUpload(let index):
                if let documentList = self.documentListCollection, index < documentList.count {
                    dataValue[field] = documentList[index].documentType
                } else {
                    break
                }
            default:
                break
            }
        }
        return dataValue
    }
    
}
