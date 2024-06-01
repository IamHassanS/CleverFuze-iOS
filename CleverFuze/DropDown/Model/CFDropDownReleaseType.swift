//
//  CFDropDownReleaseType.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - ReleaseType
struct CFDropDownReleaseType: Codable {
    let id: Int?
    var caption: String?
    let customerID: Int?
    enum CodingKeys: String, CodingKey {
        case id      = "id"
        case caption = "caption"
        case customerID = "customer_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.caption = try? container?.decodeIfPresent(String.self, forKey: .caption)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
    }
    
}

extension CFDropDownReleaseType: CFDropDownDataSource, Hashable{
    
    var name: String? {
        return self.caption
    }
    
}

