//
//  CFDashBoardDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation


// MARK: - CFDashBoardDatum
struct CFDashBoardDatum: Codable {
    let totalRecords, dataMonth, dataYear, dataWeek: Int?
    let activeRecords: Int?

    enum CodingKeys: String, CodingKey {
        case totalRecords = "total_records"
        case dataMonth = "data_month"
        case dataYear = "data_year"
        case dataWeek = "data_week"
        case activeRecords = "active_records"
    }
    
  init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    totalRecords = try? values?.decodeIfPresent(Int.self, forKey: .totalRecords)
    dataMonth = try? values?.decodeIfPresent(Int.self, forKey: .dataMonth)
    dataYear = try? values?.decodeIfPresent(Int.self, forKey: .dataYear)
    dataWeek = try? values?.decodeIfPresent(Int.self, forKey: .dataWeek)
    activeRecords = try? values?.decodeIfPresent(Int.self, forKey: .activeRecords)
  }
}

