//
//  CFReportColumn.swift
//  CleverFuze
//
//  Created by Anil Kumar on 07/09/22.
//

import Foundation

// MARK: - CFReportColumn
struct CFReportColumn: Codable {
    let title, data: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent(String.self, forKey: .data)
        self.title = try? container?.decodeIfPresent(String.self, forKey: .title)
    }
}
