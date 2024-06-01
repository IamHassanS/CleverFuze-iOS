//
//  CFLoginDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - CFLoginDatum
struct CFLoginDatum: Codable {
    
    let token: String?
    let userID: Int?
    let userRole: CFUserRole?
    let roleId: Int?

    enum CodingKeys: String, CodingKey {
        case token
        case userID = "userId"
        case userRole = "role_name"
        case roleId = "role_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.token = try? container?.decodeIfPresent(String.self, forKey: .token)
        self.userID = try? container?.decodeIfPresent(Int.self, forKey: .userID)
        self.userRole = try? container?.decodeIfPresent(CFUserRole.self, forKey: .userRole)
        self.roleId = try? container?.decodeIfPresent(Int.self, forKey: .roleId)
    }
    
}
