//
//  CFDeliveryAndDockResponse.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import Foundation


// MARK: - CFDeliveryAndDockResponse
struct CFDeliveryAndDockResponse: Codable {
    let data:  [CFDeliveryAndDockDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFDeliveryAndDockDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}

extension CFDeliveryAndDockResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.data
    }
    
}
