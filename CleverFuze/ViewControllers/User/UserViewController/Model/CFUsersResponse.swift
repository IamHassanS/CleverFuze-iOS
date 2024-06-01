//
//  CFUsersResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

// MARK: - CFUsersResponse
struct CFUsersResponse: Codable {
    let data: [CFUsersDatum]?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFUsersDatum].self, forKey: .data)
        self.status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
    }

}

extension CFUsersResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.data
    }
    
}
