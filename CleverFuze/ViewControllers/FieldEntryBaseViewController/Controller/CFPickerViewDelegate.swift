//
//  CFPickerViewDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

protocol CFPickerViewDelegate: AnyObject {
    
    func pickerDidSelected(_ dataSource: CFDropDownDataSource)
    
}
