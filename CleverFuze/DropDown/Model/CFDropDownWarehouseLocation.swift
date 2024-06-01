//
//  CFDropDownWarehouseLocation.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

// MARK: - WarehouseLocation
struct CFDropDownWarehouseLocation: Codable {
    
    let id: Int?
    let address: String?
    let customerID:Int?
    enum CodingKeys: String, CodingKey {
        case id      = "id"
        case address = "address"
        case  customerID = "customer_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.address = try? container?.decodeIfPresent(String.self, forKey: .address)
        self.customerID = try? container?.decodeIfPresent(Int.self, forKey: .customerID)
    }
}

extension CFDropDownWarehouseLocation: CFDropDownDataSource, Hashable{
    
    var name: String?{
        return self.address
    }
    
}
