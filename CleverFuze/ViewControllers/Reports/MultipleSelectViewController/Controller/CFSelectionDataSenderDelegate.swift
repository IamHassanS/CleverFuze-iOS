//
//  CFSelectionDataSenderDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 19/10/22.
//

import Foundation

protocol CFSelectionDataSenderDelegate: AnyObject{
    
    func didPassTheData(_ fieldType: CFCustomFieldType?, data: [CFDropDownDataSource])
    
}
