//
//  CFFieldEntryDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

protocol CFFieldEntryDelegate: AnyObject {
    
    func fieldEditable(_ field: CFCustomFieldType?) -> (editable:Bool, grayOut: Bool)
    func fieldDidSelected(_ field: CFCustomFieldType?)
    func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType)
    func didButtonClicked(_ buttonType: CFButtonVariety?)
    func startDate() -> Date?
    func packedDate() -> Date?
    func packedDateChanged()
    func didSelectedTheRemove(_ fieldType: CFCustomFieldType?)

}
