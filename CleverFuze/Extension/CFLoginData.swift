//
//  CFLoginData.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

// MARK: - CFLoginDataData
struct CFLoginData: Codable {
    let token: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case token
        case userID = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.token = try? container?.decodeIfPresent(String.self, forKey: .token)
        self.userID = try? container?.decodeIfPresent(Int.self, forKey: .userID)
    }
    
}
