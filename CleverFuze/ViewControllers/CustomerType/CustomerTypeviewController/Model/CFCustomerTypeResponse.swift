//
//  CFCustomerTypeResponse.swift
//  CleverFuze
//
//  Created by AIT-iMac-01 on 05/10/23.
//

import Foundation

// MARK: - Welcome
struct CFCustomerTypeResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [CFCustomerTypeDatum]?
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
    }
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFCustomerTypeDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
        self.message = try? container?.decodeIfPresent(String.self, forKey: .message)
    }
}
extension CFCustomerTypeResponse: CFRecordDataDataSourceQ{
    
    var dataSouce: [CFRecordDataSourceT]?{
        return self.data
    }
    
}
