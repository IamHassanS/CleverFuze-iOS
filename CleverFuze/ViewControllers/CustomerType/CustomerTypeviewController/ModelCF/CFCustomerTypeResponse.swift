//
//  CFCustomerTypeResponse.swift
//  CleverFuze
//
//  Created by AIT-iMac-01 on 05/10/23.
//

import Foundation
// MARK: - CFCustomerTypeResponse
struct CFCustomerTypeResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [CFCustomerTypeDatum]?
  
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try? container.decodeIfPresent(Bool.self, forKey: .status)
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
        self.data = try? container.decodeIfPresent([CFCustomerTypeDatum].self, forKey: .data)

    }
    
}

extension CFCustomerTypeResponse: CFRecordDataDataSource  {
    var dataSouce: [CFRecordDataSource]? {
        return self.data
    }
}

