//
//  CFDropDownValue.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - Customer
struct CFDropDownValue: Codable {
    
    init(id: Int?, name: String?,customerID:Int?) {
        self.id = id
        self.name = name
        self.customerID = customerID
    }
    
    
    let id: Int?
    let name: String?
    let customerID:Int?
    enum CodingKeys: String, CodingKey {
        case id   = "id"
        case name = "name"
        case customerID = "customer_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
    }
    
}

extension CFDropDownValue: CFDropDownDataSource, Hashable{ }

extension CFDropDownValue: JSONSerializable {
    
    func toSerializable() -> Any {
        return ["name": self.name as Any]
    }
}
