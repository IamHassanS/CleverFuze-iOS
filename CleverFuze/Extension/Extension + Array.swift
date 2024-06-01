//
//  Extension + Array.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

extension Array {
    func chunked(by chunkSize: Int) -> [Int:[Element]] {
        var data : [Int:[Element]] = [:]
        _ = stride(from: 0, to: self.count, by: chunkSize).enumerated().map {
            data[$0.offset] = Array(self[$0.element..<Swift.min($0.element + chunkSize, self.count)])
        }
        return data
    }
}
