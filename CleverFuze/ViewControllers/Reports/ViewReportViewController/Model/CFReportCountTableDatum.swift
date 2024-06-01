//
//  CFReportCountTableDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 07/09/22.
//

import Foundation

// MARK: - CFReportCountTableDatum
struct CFReportCountTableDatum: Codable {
    let name: String?
    let count: CFQuantumValue?
    
    enum CodingKeys: String, CodingKey {
        case name
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.count = try? container?.decodeIfPresent(CFQuantumValue.self, forKey: .count)
    }
}


extension CFReportCountTableDatum: CFRecordDataSource{
    
    var id: Int? {
        return 0
    }
    
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        [:]
    }
    
}

