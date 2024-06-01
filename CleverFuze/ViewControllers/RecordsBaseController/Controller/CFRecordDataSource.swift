//
//  CFRecordDataSource.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

protocol CFRecordDataSource{
    
    var id: Int? { get }
    var customerID: Int? { get }
    var name: String? { get }

    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType: Any]
    
}

extension CFRecordDataSource{
    
    var customerID: Int?{ return nil}
    
}
