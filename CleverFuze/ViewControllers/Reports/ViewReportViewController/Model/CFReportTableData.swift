//
//  CFReportTableData.swift
//  CleverFuze
//
//  Created by Anil Kumar on 07/09/22.
//

import Foundation

// MARK: - CFReportTableData
struct CFReportTableData: Codable {
    let data: [CFRecordDatum]?
    let columns: [CFReportColumn]?
    
    enum CodingKeys: String, CodingKey {
        case data
        case columns
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container?.decodeIfPresent([CFRecordDatum].self, forKey: .data)
        self.columns = try? container?.decodeIfPresent([CFReportColumn].self, forKey: .columns)
    }
}
