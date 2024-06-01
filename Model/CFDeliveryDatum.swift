//
//  CFDeliveryDatum.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import Foundation

// MARK: - CFDeliveryDatum
struct CFDeliveryDatum: Codable {
    let id, customerID, deliveryType: Int?
    let deliveryAddress, deliveryDate: String?
    let deliveryZone: Int?
    let staffName: String?
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
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
        self.deliveryType = try? container?.decodeIfPresent(Int.self, forKey: .deliveryType)
        self.deliveryAddress = try? container?.decodeIfPresent(String.self, forKey: .deliveryAddress)
        self.deliveryDate = try? container?.decodeIfPresent(String.self, forKey: .deliveryDate)
        self.deliveryZone = try? container?.decodeIfPresent(Int.self, forKey: .deliveryZone)
        self.staffName = try? container?.decodeIfPresent(String.self, forKey: .staffName)
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
    }

}

