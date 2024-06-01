//
//  CFWareHouseDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - CFWareHouseDatum
struct CFWareHouseDatum: Codable {
    let id: Int?
    let name, address: String?
    let storageCapacity, size: Int?
    let updateURL, deleteURL, deactivateURL: String?
    let status: CCFWareHouseStatus?

    enum CodingKeys: String, CodingKey {
        case id, name, address
        case storageCapacity = "storage_capacity"
        case size
        case updateURL = "update_url"
        case deleteURL = "delete_url"
        case deactivateURL = "deactivate_url"
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.address = try? container?.decodeIfPresent(String.self, forKey: .address)
        self.storageCapacity = try? container?.decodeIfPresent(Int.self, forKey: .storageCapacity)
        self.size = try? container?.decodeIfPresent(Int.self, forKey: .size)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.deleteURL = try? container?.decodeIfPresent(String.self, forKey: .deleteURL)
        self.deactivateURL = try? container?.decodeIfPresent(String.self, forKey: .deactivateURL)
        self.status = try? container?.decodeIfPresent(CCFWareHouseStatus.self, forKey: .status)
    }
    
}

extension CFWareHouseDatum: CFRecordDataSource{
    
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .name:
                valueDatas[field] = self.name
            case .address:
                valueDatas[field] = self.address
            case .storageCapacity:
                valueDatas[field] = String(self.storageCapacity ?? 0)
            case .size:
                valueDatas[field] = String(self.size ?? 0)
            default:
                break
            }
        }
        return valueDatas
    }
    
}
