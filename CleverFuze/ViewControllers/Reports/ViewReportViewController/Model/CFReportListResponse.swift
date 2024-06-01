//
//  CFReportListResponse.swift
//  CleverFuze
//
//  Created by venkat subramaian on 09/09/22.
//

import Foundation
// MARK: - CFReportListResponse
struct CFReportListResponse: Codable {
    let title: [CFReportDatum]?
    let data: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.title = try? container?.decodeIfPresent([CFReportDatum].self, forKey: .title)
        self.data = try? container?.decodeIfPresent(String.self, forKey: .data)
    }
}
extension CFReportListResponse: CFRecordDataDataSource{
    
    var dataSouce: [CFRecordDataSource]?{
        return self.title
    }

}
