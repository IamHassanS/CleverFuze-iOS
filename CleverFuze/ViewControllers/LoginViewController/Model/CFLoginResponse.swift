//
//  CFLoginView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import Foundation

// MARK: - CFLoginResponse
struct CFLoginResponse: Codable {
    
    let status: Bool?
    let data: CFLoginDatum?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent(CFLoginDatum.self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
        self.error = try? container?.decodeIfPresent(String.self, forKey: .error)
    }
}
