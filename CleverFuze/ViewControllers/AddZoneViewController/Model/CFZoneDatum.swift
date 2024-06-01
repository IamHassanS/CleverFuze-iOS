//
//  CFZoneDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 12/10/22.
//

import Foundation

// MARK: - Datum
struct CFZoneDatum: Codable {
    let id: Int?
    let caption: String?
    let isActive: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, caption
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.caption = try? container?.decodeIfPresent(String.self, forKey: .caption)
        self.isActive = try? container?.decodeIfPresent(Int.self, forKey: .isActive)
        self.createdAt = try? container?.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? container?.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

extension CFZoneDatum: CFRecordDataSource{
    
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        return [.zoneEntry(0): self.caption as Any, .zoneSelectAddEdit: self.caption as Any]
    }
    
    
    var customerID: Int?{ return nil }
    var name: String? { return self.caption }
    
}
