//
//  CFMultipleSelectionDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 18/10/22.
//

import Foundation

protocol CFMultipleSelectionDelegate: AnyObject {
    
    func didSelectedTheValue(_ index: Int)
    func closeButtonClicked()
    func doneButtonClicked()
    
}
