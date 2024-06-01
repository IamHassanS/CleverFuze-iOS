//
//  CFFieldChangesResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import Foundation

struct CFFieldChangesResponse: Codable {
    
    let data: String?
    let status: Bool?
    var error: [String]?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decodeIfPresent(String.self, forKey: .data)
        self.status = try? container.decodeIfPresent(Bool.self, forKey: .status)

        if let singleError: String = try? container.decodeIfPresent(String.self, forKey: .error) {
            self.error = [singleError]
        } else {
            self.error = try? container.decodeIfPresent([String].self, forKey: .error)
        }
    }
}
