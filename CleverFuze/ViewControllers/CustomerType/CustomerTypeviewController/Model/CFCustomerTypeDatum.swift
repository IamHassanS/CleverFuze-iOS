//
//  CFCustomerTypeDatum.swift
//  CleverFuze
//
//  Created by AIT-iMac-01 on 05/10/23.
//

import Foundation


// MARK: - Datum
struct CFCustomerTypeDatum: Codable {
    let id: Int?
    let caption: String?
    let isActive: Int?

    enum CodingKeys: String, CodingKey {
        case id, caption
        case isActive = "is_active"
    }
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.caption = try? container?.decodeIfPresent(String.self, forKey: .caption)
        self.isActive = try? container?.decodeIfPresent(Int.self, forKey: .isActive)
    }
}
