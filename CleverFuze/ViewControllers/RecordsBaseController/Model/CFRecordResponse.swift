//
//  CFRecordResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

// MARK: - CFRecordResponse
struct CFRecordResponse: Codable {
    
    let data: [CFRecordDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decode([CFRecordDatum].self, forKey: .data)
        self.status = try? container?.decode(Bool.self, forKey: .status)
    }
}

extension CFRecordResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.data
    }
    
}
