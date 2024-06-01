//
//  CFDropDownCompany.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - Company
struct CFDropDownCompany: Codable {
    let id: Int?
    let companyName: String?
    let customerID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case customerID =  "customer_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.companyName = try? container?.decodeIfPresent(String.self, forKey: .companyName)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
    }
    
}

extension CFDropDownCompany: CFDropDownDataSource, Hashable{
    
    var name: String?{
        return self.companyName
    }
    
}
