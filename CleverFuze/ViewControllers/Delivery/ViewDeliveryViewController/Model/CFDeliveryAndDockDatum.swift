//
//  CFDeliveryAndDockDatum.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import Foundation

// MARK: - CFDeliveryAndDockDatum
struct CFDeliveryAndDockDatum: Codable {
    let id, customerID, deliveryType: Int?
    let deliveryAddress, deliveryDate: String?
    let deliveryZone: Int?
    let staffName: [String]?
    let propertyWeight: Int?
    let deliveryoutRate: Double?
    let damageMissingItem, releaseIncome: Int?
    let filePath, createdAt, updatedAt: String?
    let deletedAt: String?
    let customerName: String?
    let deliveryTypeCap: String?
    let deliveryZoneCap: String?
    let staffNameAll: String?
    let updateURL, deleteURL: String?
    
    let companyID: Int?
    let companyPickup: String?
    let releaseDate: String?
    let handlingoutFee: Double?
    let customerType: Int?
    let companyName: String?
    let pickupCompany: String?
    let pickupCompanyID: String?
    let customerCompany: Int?
    let documentUrl : String?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case deliveryType = "delivery_type"
        case deliveryAddress = "delivery_address"
        case deliveryDate = "delivery_date"
        case deliveryZone = "delivery_zone"
        case staffName = "staff_name"
        case propertyWeight = "property_weight"
        case deliveryoutRate = "deliveryout_rate"
        case damageMissingItem = "damage_missing_item"
        case releaseIncome = "release_income"
        case filePath = "file_path"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case customerName = "customer_name"
        case deliveryTypeCap = "delivery_type_cap"
        case deliveryZoneCap = "delivery_zone_cap"
        case staffNameAll = "staff_name_all"
        case updateURL = "update_url"
        case deleteURL = "delete_url"
        
        case companyID = "company_id"
        case companyPickup = "company_pickup"
        case releaseDate = "release_date"
        case handlingoutFee = "handlingout_fee"
        case customerType = "customer_type"
        case companyName = "company_name"
        case pickupCompany = "pickup_company"
        case pickupCompanyID = "pickup_company_id"
        case customerCompany = "customer_company"
        case documentUrl = "documentUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
        self.deliveryType = try? container?.decodeIfPresent(Int.self, forKey: .deliveryType)
        self.deliveryAddress = try? container?.decodeIfPresent(String.self, forKey: .deliveryAddress)
        self.deliveryDate = try? container?.decodeIfPresent(String.self, forKey: .deliveryDate)
        self.deliveryZone = try? container?.decodeIfPresent(Int.self, forKey: .deliveryZone)

        let staffNameStr = try? container?.decodeIfPresent(String.self, forKey: .staffName)
        let names = staffNameStr?.trimmingCharacters(in: .whitespaces)
        self.staffName = names?.components(separatedBy: ",")

        self.propertyWeight = try? container?.decodeIfPresent(Int.self, forKey: .propertyWeight)
        self.deliveryoutRate = try? container?.decodeIfPresent(Double.self, forKey: .deliveryoutRate)
        self.damageMissingItem = try? container?.decodeIfPresent(Int.self, forKey: .damageMissingItem)
        self.releaseIncome = try? container?.decodeIfPresent(Int.self, forKey: .releaseIncome)
        self.filePath = try? container?.decodeIfPresent(String.self, forKey: .filePath)
        self.createdAt = try? container?.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? container?.decodeIfPresent(String.self, forKey: .updatedAt)
        self.deletedAt = try? container?.decodeIfPresent(String.self, forKey: .deletedAt)
        self.customerName = try? container?.decodeIfPresent(String.self, forKey: .customerName)
        self.deliveryTypeCap = try? container?.decodeIfPresent(String.self, forKey: .deliveryTypeCap)
        self.deliveryZoneCap = try? container?.decodeIfPresent(String.self, forKey: .deliveryZoneCap)
        self.staffNameAll = try? container?.decodeIfPresent(String.self, forKey: .staffNameAll)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.deleteURL = try? container?.decodeIfPresent(String.self, forKey: .deleteURL)
        
        self.companyID = try? container?.decodeIfPresent(Int.self, forKey: .companyID)
        self.companyPickup = try? container?.decodeIfPresent(String.self, forKey: .companyPickup)
        self.releaseDate = try? container?.decodeIfPresent(String.self, forKey: .releaseDate)
        self.handlingoutFee = try? container?.decodeIfPresent(Double.self, forKey: .handlingoutFee)
        self.customerType = try? container?.decodeIfPresent(Int.self, forKey: .customerType)
        self.companyName = try? container?.decodeIfPresent(String.self, forKey: .companyName)
        self.pickupCompany = try? container?.decodeIfPresent(String.self, forKey: .pickupCompany)
        self.pickupCompanyID = try? container?.decodeIfPresent(String.self, forKey: .pickupCompanyID)
        self.customerCompany = try? container?.decodeIfPresent(Int.self, forKey: .customerCompany)
        self.documentUrl = try? container?.decodeIfPresent(String.self, forKey: .documentUrl)
    }

}



extension CFDeliveryAndDockDatum: CFRecordDataSource{
    
    var name: String? {
        return self.customerName
    }

    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .customerName:
                valueDatas[field] = CFDropDownController.dropDownValues?.customers?.filter {
                    $0.name?.lowercased() == self.customerName?.lowercased() || $0.id == self.customerID
                }.first ?? self.customerName
            case .deliveryType:
                valueDatas[field] = CFDropDownController.dropDownValues?.releaseType?.filter{$0.id == self.deliveryType}.first
            case .deliveryAddress:
                valueDatas[field] = self.deliveryAddress
            case .deliveryDate:
                valueDatas[field] = self.deliveryDate
            case .deliveryZone:
                valueDatas[field] = CFDropDownController.dropDownValues?.zoneTypes?.filter{$0.id == self.deliveryZone}.first
            case .propertyWeight:
                valueDatas[field] = String(self.propertyWeight ?? 0)
            case .deliveryoutRate:
                valueDatas[field] = String(self.deliveryoutRate ?? 0)
            case .releaseIncome:
                valueDatas[field] = String(self.releaseIncome ?? 0)
            case .damagaeMissingItems:
                valueDatas[field] = CFDropDownController.dropDownValues?.damagaeMissingItems?.filter{$0.id == self.damageMissingItem}.first
            case .staffName:
                valueDatas[field] = self.staffName?.first

            case .releasetype:
                valueDatas[field] = CFDropDownController.dropDownValues?.releaseType?.filter{$0.id == self.deliveryType}.first
            case .companyAndOrganization:
                valueDatas[field] = CFDropDownController.dropDownValues?.company?.filter{$0.id == self.customerCompany}.first
            case .pickupCompany:
                valueDatas[field] = self.companyPickup
            case .releaseWeight:
                valueDatas[field] = String(self.propertyWeight ?? 0)
            case .releaseDate:
                valueDatas[field] = self.releaseDate
            case .handlingoutFee:
                valueDatas[field] = String(self.handlingoutFee ?? 0)
            case.companyName:
                valueDatas[field] = self.companyName
            case .fileInput(_):
                valueDatas[field] = self.documentUrl
            default:
                break
               // valueDatas[field] = nil
            }
        }
        
        return valueDatas
        
    }
}

