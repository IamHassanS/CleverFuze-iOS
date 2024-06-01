//
//  CFCustomerTypeStatus.swift
//  CleverFuze
//
//  Created by AIT-iMac-01 on 17/10/23.
//

import Foundation

enum CFCustomerTypeStatus: Int, Codable{

    case Disable = 0
    case Enable 

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
