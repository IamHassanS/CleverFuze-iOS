//
//  CFDockDatum.swift
//  CleverFuze
//
//  Created by Anilkumar on 31/08/22.
//

import Foundation

// MARK: - CFDockDatum
struct CFDockDatum: Codable {
    let id, customerID: Int
    let deliveryType, companyID: Int?
    let companyPickup: String?
    let releaseDate: String
    let propertyWeight: Int
    let staffName: String?
    let damageMissingItem: Int?
    let filePath: String
    let handlingoutFee: Double
    let releaseIncome: Int?
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?
    let customerName: String
    let customerType: Int
    let companyName: String?
    let pickupCompany: JSONNull?
    let deliveryTypeCap: String?
    let pickupCompanyID: JSONNull?
    let customerCompany: Int?
    let staffNameAll: String
    let updateURL, deleteURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case deliveryType = "delivery_type"
        case companyID = "company_id"
        case companyPickup = "company_pickup"
        case releaseDate = "release_date"
        case propertyWeight = "property_weight"
        case staffName = "staff_name"
        case damageMissingItem = "damage_missing_item"
        case filePath = "file_path"
        case handlingoutFee = "handlingout_fee"
        case releaseIncome = "release_income"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case customerName = "customer_name"
        case customerType = "customer_type"
        case companyName = "company_name"
        case pickupCompany = "pickup_company"
        case deliveryTypeCap = "delivery_type_cap"
        case pickupCompanyID = "pickup_company_id"
        case customerCompany = "customer_company"
        case staffNameAll = "staff_name_all"
        case updateURL = "update_url"
        case deleteURL = "delete_url"
    }
}
