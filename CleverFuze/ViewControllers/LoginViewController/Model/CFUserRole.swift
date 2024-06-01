//
//  CFUserRole.swift
//  CleverFuze
//
//  Created by Anil Kumar on 10/10/22.
//

import Foundation

enum CFUserRole: String {

    case admin = "Administrator"
    case manager = "Manager"
    case member = "Member"
    
}

extension CFUserRole: Codable{
    
    init(from decoder: Decoder) throws {
        
        guard let value = try? decoder.singleValueContainer().decode(String.self) else{
            throw ErrorValue.DecodeError
        }
        self = Self(rawValue: value) ?? .member
        
    }
    
    enum ErrorValue: Error{
        
        case DecodeError
        
    }
    
}
