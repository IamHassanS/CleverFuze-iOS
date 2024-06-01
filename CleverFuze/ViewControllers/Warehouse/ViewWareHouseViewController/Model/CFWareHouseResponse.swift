//
//  CFWareHouseResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - CFWareHouseResponse
struct CFWareHouseResponse: Codable {
    let data: [CFWareHouseDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFWareHouseDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}

extension CFWareHouseResponse: CFRecordDataDataSource  {
    var dataSouce: [CFRecordDataSource]? {
        return self.data 
    }
}
