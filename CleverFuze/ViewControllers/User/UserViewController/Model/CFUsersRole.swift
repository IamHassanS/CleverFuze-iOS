//
//  CFUsersRole.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

enum CFUsersRole: String, Codable {
    
    case admin = "Admin"
    case administrator = "Administrator"
    case employee = "Employee"
    case manager = "Manager"
    case member = "Member"
    
    init(from decoder: Decoder) throws {
        
        guard let container = try? decoder.singleValueContainer().decode(String.self), let value = Self(rawValue: container) else {
            throw CFUnIdentifyRoleError.unIdentifyRole
        }
        self = value == .admin ? .administrator : value
        
    }
    
    enum CFUnIdentifyRoleError: Error{
        case unIdentifyRole
    }
    
}
