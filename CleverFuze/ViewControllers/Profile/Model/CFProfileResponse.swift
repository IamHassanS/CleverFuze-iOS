//
//  CFProfileResponse.swift
//  CleverFuze
//
//  Created by venkat subramaian on 13/09/22.
//

import Foundation
// MARK: - CFProfileResponse
struct CFProfileResponse: Codable {
    let status: Bool?
    let data: CFProfileDataclass?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
        self.data = try? container?.decodeIfPresent(CFProfileDataclass.self, forKey: .data)
    }
    
}
