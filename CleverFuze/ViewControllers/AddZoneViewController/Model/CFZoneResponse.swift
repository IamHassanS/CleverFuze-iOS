//
//  CFZoneResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 12/10/22.
//

import Foundation

// MARK: - CFZoneResponse
struct CFZoneResponse: Codable {
    let data: [CFZoneDatum]?
    let status: Bool?
    
    enum CodingKeys: CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFZoneDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

extension CFZoneResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.data
    }
    
}
