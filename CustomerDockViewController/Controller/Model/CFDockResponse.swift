//
//  CFDockResponse.swift
//  CleverFuze
//
//  Created by Anilkumar on 31/08/22.
//

import Foundation

// MARK: - CFDockResponse
struct CFDockResponse: Codable {
    let data:  [CFDockDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data   = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFDockDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}
