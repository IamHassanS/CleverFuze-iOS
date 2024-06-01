//
//  CFCompanyListResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

// MARK: - CFCompanyListResponse
struct CFCompanyListResponse: Codable {
    let data: [CFCompanyListDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFCompanyListDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

extension CFCompanyListResponse: CFRecordDataDataSource{
    var dataSouce: [CFRecordDataSource]?{
        return self.data
    }
}
