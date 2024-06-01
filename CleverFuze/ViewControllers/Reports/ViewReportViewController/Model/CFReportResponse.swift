//
//  CFReportResponse.swift
//  CleverFuze
//
//  Created by Anil Kumar on 07/09/22.
//

import Foundation

// MARK: - CFReportResponse
struct CFReportResponse: Codable {
    let testquery: String?
    let testquery2: [String]?
    let tableData: CFReportTableData?
    let countTableData: [CFReportCountTableDatum]?
    let chartData: [Double]?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case testquery, testquery2
        case tableData = "table_data"
        case countTableData = "count_table_data"
        case chartData = "chart_data"
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.testquery = try? container?.decodeIfPresent(String.self, forKey: .testquery)
        self.testquery2 = try? container?.decodeIfPresent([String].self, forKey: .testquery2)
        self.tableData = try? container?.decodeIfPresent(CFReportTableData.self, forKey: .tableData)
        self.countTableData = try? container?.decodeIfPresent([CFReportCountTableDatum].self, forKey: .countTableData)
        
        let cData = try? container?.decodeIfPresent(String.self, forKey: .chartData)
        self.chartData = try? JSONDecoder().decode([Double].self, from: cData?.data(using: .utf8) ?? Data())
        self.status = try? container?.decodeIfPresent(String.self, forKey: .status)
    }
    
}

extension CFReportResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.tableData?.data
    }
    
}
