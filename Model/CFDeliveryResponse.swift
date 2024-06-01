//
//  CFDeliveryResponse.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import Foundation


// MARK: - CFDeliveryResponse
struct CFDeliveryResponse: Codable {
    let data:  [CFDeliveryDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data   = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFDeliveryDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}
