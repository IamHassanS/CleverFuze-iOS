//
//  CFDropDownResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - CFDropDownResponse
struct CFDropDownResponse: Codable {
    let data: CFDropDownDatum?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data   = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent(CFDropDownDatum.self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}

