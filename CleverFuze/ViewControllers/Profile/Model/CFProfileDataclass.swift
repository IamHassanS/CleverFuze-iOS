//
//  CFProfileDataclass.swift
//  CleverFuze
//
//  Created by venkat subramaian on 13/09/22.
//

import Foundation

// MARK: - CFProfileDataclass
struct CFProfileDataclass: Codable {
    
    let profile: CFProfileViewDatum?
    
    enum CodingKeys: String, CodingKey{
        case profile
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.profile = try? container?.decodeIfPresent(CFProfileViewDatum.self, forKey: .profile)
    }
    
}

struct WarehouseCurrentStorageDatum: Codable {
    let totlCapacity: Int
    let currentStorage: String
    let availableStorage: Int
    let status: String
    let testQuery: [String]

    enum CodingKeys: String, CodingKey {
        case totlCapacity = "totl_capacity"
        case currentStorage = "current_storage"
        case availableStorage = "available_storage"
        case status
        case testQuery = "test_query"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totlCapacity = try container.decode(Int.self, forKey: .totlCapacity)
        self.currentStorage = try container.decode(String.self, forKey: .currentStorage)
        self.availableStorage = try container.decode(Int.self, forKey: .availableStorage)
        self.status = try container.decode(String.self, forKey: .status)
        self.testQuery = try container.decode([String].self, forKey: .testQuery)
    }
}
