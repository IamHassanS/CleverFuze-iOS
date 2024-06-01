//
//  CFQuantumValue.swift
//  CleverFuze
//
//  Created by Anil Kumar on 07/09/22.
//

import Foundation

enum CFQuantumValue: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        if let x = try? container?.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container?.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CFQuantumValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Count"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

extension CFQuantumValue{
    
    var intValue: Int{
        switch self {
        case .integer(let int):
            return int
        case .string(let string):
            return Int(string) ?? 0
        }
    }
    
    var stringValue: String{
        switch self {
        case .integer(let int):
            return String(int)
        case .string(let string):
            return string
        }
    }
    
    var dollarValue: String{
        switch self {
        case .integer(let int):
            return "$\(int)"
        case .string(let string):
            return string
        }
    }
    
}
