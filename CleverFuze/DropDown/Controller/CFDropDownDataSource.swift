//
//  CFDropDownDataSource.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

protocol CFDropDownDataSource {
    var id: Int? { get }
    var name: String? { get }
    var customerID: Int? { get } // Add the customerID property
}

extension CFDropDownDataSource {
    static func ==(_ lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.customerID == rhs.customerID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id?.hashValue)
        hasher.combine(self.customerID?.hashValue) // Include customerID in the hash calculation
    }
}
