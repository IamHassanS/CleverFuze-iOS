//
//  dashBoardApi.swift
//  CleverFuze
//
//  Created by Ajith  on 07/06/22.
//

import Foundation

// MARK: - DashBoard
struct CFDashBoardResponse: Codable {
    let data: CFDashBoardDatum?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent(CFDashBoardDatum.self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
