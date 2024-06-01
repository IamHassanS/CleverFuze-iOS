//
//  CFBaseFieldEntryDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import Foundation

protocol CFBaseFieldEntryDelegate: CFBaseDelegate{
    
    func didButtonClicked(_ buttonType: CFButtonVariety?)
    func fieldDidSelected(_ type: CFCustomFieldType?)
    func reloadTheTableView()
    
}
