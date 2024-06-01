//
//  CFDropDownDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - DataClass
struct CFDropDownDatum: Codable {
    
    let customerTypes: [CFDropDownReleaseType]?
    let zoneTypes: [CFDropDownReleaseType]?
    let warehouse: [CFDropDownValue]?
    let company: [CFDropDownCompany]?
    let documentTypes: [CFDropDownReleaseType]?
    let warehouseLocation: [CFDropDownWarehouseLocation]?
    let customers: [CFDropDownValue]?
    let releaseType, userRole: [CFDropDownReleaseType]?
    let states: [CFDropDownValue]?
    let damagaeMissingItems: [CFDropDownValue]?
    let userStatus: [CFDropDownValue]?
    var customerRelease: [CFDropDownValue]?
    
    enum CodingKeys: String, CodingKey {
        case customerTypes = "customer_types"
        case zoneTypes = "zone_types"
        case warehouse, company
        case documentTypes = "document_types"
        case warehouseLocation = "warehouse_location"
        case customers
        case releaseType = "Release_type"
        case userRole = "user_role"
        case states
        case damagaeMissingItems = "damagae/missing items"
        case userStatus = "user_status"
        case customerRelease = "customer_release"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.customerTypes = try? container?.decodeIfPresent([CFDropDownReleaseType].self, forKey: .customerTypes)
        self.zoneTypes = try? container?.decodeIfPresent([CFDropDownReleaseType].self, forKey: .zoneTypes)
        self.warehouse = try? container?.decodeIfPresent([CFDropDownValue].self, forKey: .warehouse)
        self.company = try? container?.decodeIfPresent([CFDropDownCompany].self, forKey: .company)
        self.documentTypes = try? container?.decodeIfPresent([CFDropDownReleaseType].self, forKey: .documentTypes)
        self.warehouseLocation = try? container?.decodeIfPresent([CFDropDownWarehouseLocation].self, forKey: .warehouseLocation)
        self.customers = try? container?.decodeIfPresent([CFDropDownValue].self, forKey: .customers)
        self.releaseType = try? container?.decodeIfPresent([CFDropDownReleaseType].self, forKey: .releaseType)
        self.userRole = try? container?.decodeIfPresent([CFDropDownReleaseType].self, forKey: .userRole)
        
        // For state
        let state = (try? container?.decodeIfPresent(String.self, forKey: .states)) ?? ""
        let states = try? JSONDecoder().decode([String].self, from: state.data(using: .utf8)!)
        self.states = states?.enumerated().compactMap{.init(id: nil, name: $0.element, customerID: nil)}
        
        // For damagae Missing Item
        let damagaeMissingItem = (try? container?.decodeIfPresent(String.self, forKey: .damagaeMissingItems)) ?? ""
        let damagaeMissingItems = try? JSONDecoder().decode([String:String].self, from: damagaeMissingItem.data(using: .utf8)!)
        self.damagaeMissingItems = damagaeMissingItems?.enumerated().compactMap{.init(id: $0.offset, name: $0.element.value, customerID: nil)}

        // For user Status
        let userStatus = (try? container?.decodeIfPresent(String.self, forKey: .userStatus)) ?? ""
        let userStatuses = try? JSONDecoder().decode([String: String].self, from: userStatus.data(using: .utf8)!)
        self.userStatus = userStatuses?.enumerated().compactMap{.init(id: nil, name: $0.element.value, customerID: nil)}

        // For customer Release
        let customerRelease = (try? container?.decodeIfPresent(String.self, forKey: .customerRelease)) ?? ""
        let customerReleases = try? JSONDecoder().decode([String:String].self, from: customerRelease.data(using: .utf8)!)
        self.customerRelease = customerReleases?.enumerated().compactMap{.init(id: nil, name: $0.element.value, customerID: nil)}
        
    }
}
