//
//  CCFWareHouseStatus.swift
//  CleverFuze
//
//  Created by Anil Kumar on 13/09/22.
//

import Foundation

enum CCFWareHouseStatus: Int, Codable{
    
    case deActivate = 0
    case activate = 1

    init(from decoder: Decoder) throws {
        
        guard let intValue = try? decoder.singleValueContainer().decode(Int.self) else {
            throw Errors.valueNotFound
        }
        guard let value = Self(rawValue: intValue) else{
            throw Errors.unExpectedValue
        }
        self = value
    }
    
    enum Errors: Error {
        
        case valueNotFound
        case unExpectedValue

    }
    
}
