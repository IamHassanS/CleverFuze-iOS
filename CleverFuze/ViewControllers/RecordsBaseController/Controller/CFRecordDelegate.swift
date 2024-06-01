//
//  CFRecordDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

protocol CFRecordDelegate: CFBaseDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?)
    
}
