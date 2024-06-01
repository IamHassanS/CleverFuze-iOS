//
//  CFReportDatum.swift
//  CleverFuze
//
//  Created by venkat subramaian on 09/09/22.
//

import Foundation
// MARK: - CFReportDatum
struct CFReportDatum: Codable {
    let custID: Int?
    let name: String?
    let customerType: String?
    let id, customerID: Int?
    let propertyLocation: String?
    let  customerstatus: String?
    let storageValues, liftWanes: Int?
    let overflow: String?
    let initialActualweight, lotnumber, packdateIn, expecteddateOut: String?
    let estimatedweight, actualweight, loadDate: String?
    let zone: String?
    let totalinRate: String?
    let handlingIn: Int?
    let storagerate: Int?
    let customerWarehouse: String?
    let customerCompany: String?
    let expectedmonthsStorage: Int?
    let createdAt, updatedAt: String?
    let deletedAt, dockCustomer, dockID, deliveryID: String?
    let deliveryCustomer, dockReleaseType, deliveryReleaseType: String?
    let customerIncome: Int?
    let initialStorageIncome, quarterlyStorageIncome: Double?
    let customerRelease, releaseType, releasedWeight, releasedDate: String?
    let outRate, outRateCap: String?
    let quarterStorageIncome: String?
    let storageIncome, storageReleaseIncome, totalIncome: String?
    let action: String?
    let address: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip: String?
    enum CodingKeys: String, CodingKey {
        case custID = "cust_id"
        case name
        case customerType = "customer_type"
        case id
        case customerID = "customer_id"
        case propertyLocation = "property_location"
        case customerstatus = "customer_status"
        case storageValues = "storage_values"
        case liftWanes = "lift_wanes"
        case overflow
        case initialActualweight = "initial_actualweight"
        case lotnumber
        case packdateIn = "packdate_in"
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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case dockCustomer = "dock_customer"
        case dockID = "dock_id"
        case deliveryID = "delivery_id"
        case deliveryCustomer = "delivery_customer"
        case dockReleaseType = "dock_release_type"
        case deliveryReleaseType = "delivery_release_type"
        case customerIncome = "customer_income"
        case initialStorageIncome = "initial_storage_income"
        case quarterlyStorageIncome = "quarterly_storage_income"
        case customerRelease = "customer_release"
        case releaseType = "release_type"
        case releasedWeight = "released_weight"
        case releasedDate = "released_date"
        case outRate = "out_rate"
        case outRateCap = "out_rate_cap"
        case quarterStorageIncome = "quarter_storage_income"
        case storageIncome = "storage_income"
        case storageReleaseIncome = "storage_release_income"
        case totalIncome = "total_income"
        case action
        case address, address2, city, state, zip
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.custID = try? container?.decodeIfPresent(Int.self, forKey: .custID)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.customerType = try? container?.decodeIfPresent(String.self, forKey: .customerType)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
        self.propertyLocation = try? container?.decodeIfPresent(String.self, forKey: .propertyLocation)
        self.customerstatus = try? container?.decodeIfPresent(String.self, forKey: .customerstatus )
        self.storageValues = try? container?.decodeIfPresent(Int.self, forKey: .storageValues)
        self.liftWanes = try? container?.decodeIfPresent(Int.self, forKey: .liftWanes)
        self.overflow = try? container?.decodeIfPresent(String.self, forKey: .overflow)
        self.initialActualweight = try? container?.decodeIfPresent(String.self, forKey: .initialActualweight)
        self.lotnumber = try? container?.decodeIfPresent(String.self, forKey: .lotnumber)
        self.packdateIn = try? container?.decodeIfPresent(String.self, forKey: .packdateIn)
        self.expecteddateOut = try? container?.decodeIfPresent(String.self, forKey: .expecteddateOut)
        self.estimatedweight = try? container?.decodeIfPresent(String.self, forKey: .estimatedweight)
        self.actualweight = try? container?.decodeIfPresent(String.self, forKey: .actualweight)
        self.loadDate = try? container?.decodeIfPresent(String.self, forKey: .loadDate)
        self.zone = try? container?.decodeIfPresent(String.self, forKey: .zone)
        self.totalinRate = try? container?.decodeIfPresent(String.self, forKey: .totalinRate)
        self.handlingIn = try? container?.decodeIfPresent(Int.self, forKey: .handlingIn)
        self.storagerate = try? container?.decodeIfPresent(Int.self, forKey: .storagerate)
        self.customerWarehouse = try? container?.decodeIfPresent(String.self, forKey: .customerWarehouse)
        self.customerCompany = try? container?.decodeIfPresent(String.self, forKey: .customerCompany)
        self.expectedmonthsStorage = try? container?.decodeIfPresent(Int.self, forKey: .expectedmonthsStorage)
        self.createdAt = try? container?.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? container?.decodeIfPresent(String.self, forKey: .updatedAt)
        self.deletedAt = try? container?.decodeIfPresent(String.self, forKey: .deletedAt)
        self.dockCustomer = try? container?.decodeIfPresent(String.self, forKey: .dockCustomer)
        self.dockID = try? container?.decodeIfPresent(String.self, forKey: .dockID)
        self.deliveryID = try? container?.decodeIfPresent(String.self, forKey: .deliveryID)
        self.deliveryCustomer = try? container?.decodeIfPresent(String.self, forKey: .deliveryCustomer)
        self.dockReleaseType = try? container?.decodeIfPresent(String.self, forKey: .dockReleaseType)
        self.deliveryReleaseType = try? container?.decodeIfPresent(String.self, forKey: .deliveryReleaseType)
        self.customerIncome = try? container?.decodeIfPresent(Int.self, forKey: .customerIncome)
        self.initialStorageIncome = try? container?.decodeIfPresent(Double.self, forKey: .initialStorageIncome)
        self.quarterlyStorageIncome = try? container?.decodeIfPresent(Double.self, forKey: .quarterlyStorageIncome)
        self.customerRelease = try? container?.decodeIfPresent(String.self, forKey: .customerRelease)
        self.releaseType = try? container?.decodeIfPresent(String.self, forKey: .releaseType)
        self.releasedWeight = try? container?.decodeIfPresent(String.self, forKey: .releasedWeight)
        self.releasedDate = try? container?.decodeIfPresent(String.self, forKey: .releasedDate)
        self.outRate = try? container?.decodeIfPresent(String.self, forKey: .outRate)
        self.outRateCap = try? container?.decodeIfPresent(String.self, forKey: .outRateCap)
        self.quarterStorageIncome = try? container?.decodeIfPresent(String.self, forKey: .quarterStorageIncome)
        self.storageIncome = try? container?.decodeIfPresent(String.self, forKey: .storageIncome)
        self.storageReleaseIncome = try? container?.decodeIfPresent(String.self, forKey: .storageReleaseIncome)
        self.totalIncome = try? container?.decodeIfPresent(String.self, forKey: .totalIncome)
        self.action = try? container?.decodeIfPresent(String.self, forKey: .action)
        self.address = try? container?.decodeIfPresent(String.self, forKey: .address)
        self.address2 = try? container?.decodeIfPresent(String.self, forKey: .address2)
        self.city = try? container?.decodeIfPresent(String.self, forKey: .city)
        self.state = try? container?.decodeIfPresent(String.self, forKey: .state)
        self.zip = try? container?.decodeIfPresent(String.self, forKey: .zip)
    }
    
}


extension CFReportDatum: CFRecordDataSource{
    
    var customerName: String? {
        return self.name
    }

    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .customerName,.namesz:
                valueDatas[field] = CFDropDownController.dropDownValues?.customers?.filter{$0.name == self.customerName}.first
            case .customerType,.customertypsz:
                valueDatas[field] = CFDropDownController.dropDownValues?.customerTypes?.filter{$0.name?.lowercased() == self.customerType?.lowercased()}.first
            case .propertyLocation:
                valueDatas[field] = self.propertyLocation
            case .initialStorage:
                valueDatas[field] = String(self.initialStorageIncome ?? 0)
            case .propertyAddress:
                valueDatas[field] = self.address
            case .addressLine2:
                valueDatas[field] = self.address2
            case .city:
                valueDatas[field] = self.city
            case .state:
                valueDatas[field] = CFDropDownController.dropDownValues?.states?.filter{$0.name?.lowercased() == self.state?.lowercased()}.first
            case .zipcode:
                valueDatas[field] = self.zip
            case .customerstatus:
                valueDatas[field] = self.customerRelease
            case .initialActualWeight,.intialActualWightz:
                valueDatas[field] = self.actualweight
            case .estimatedDateOut:
                valueDatas[field] = self.expecteddateOut
            case .lotNumber,.lotnumberz:
                valueDatas[field] = self.lotnumber
            case .packDateIn,.packedDateInz:
                valueDatas[field] = self.packdateIn
            case .estimatedWeight:
                valueDatas[field] =  self.estimatedweight
            case .actualWeight,.actualWeightz:
                valueDatas[field] = self.actualweight
            case .loadDate,.loadDatez:
                valueDatas[field] =  self.loadDate 
//            case .customerzone:
//                valueDatas[field] = self.zone
//        MARK: Below changes for to adding customers name field  in report management :
            case .customersname:
                valueDatas[field] = self.customerName
            case .totalRateIn,.totalRateInz:
                valueDatas[field] = self.totalinRate
            case .storageRate,.storageRatez:
                valueDatas[field] =  self.storagerate
            case .warehouse:
                valueDatas[field] = CFDropDownController.dropDownValues?.warehouseLocation?.filter{$0.name == self.customerWarehouse}.first
            case .customerRelease:
                valueDatas[field] =  self.customerRelease
            case .releasetype:
                valueDatas[field] = self.customerRelease
            case .releaseWeight,.releaseWeightz:
                valueDatas[field] = self.releasedWeight
            case .releaseDate,.releaseDatez:
                valueDatas[field] =  self.releasedDate
            case .deliveryoutRate,.deliveryoutRatez:
                valueDatas[field] = self.outRate
            case .quarterlyStorage:
                valueDatas[field] = String(self.quarterStorageIncome ?? "")
            case .totalHandling:
                valueDatas[field] = self.handlingIn
            case .storageVaults:
                valueDatas[field] =  self.storageReleaseIncome
            case .StorageReleaseIncome:
                valueDatas[field] =  self.storageReleaseIncome
            case .totalIncome:
                valueDatas[field] = self.totalIncome
            default:
                break
            }
        }
        return valueDatas
        
    }
}
