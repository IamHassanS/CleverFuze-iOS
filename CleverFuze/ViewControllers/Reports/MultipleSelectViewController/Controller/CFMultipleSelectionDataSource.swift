//
//  CFMultipleSelectionStyle.swift
//  CleverFuze
//
//  Created by Anil Kumar on 18/10/22.
//

import Foundation

protocol CFMultipleSelectionDataSource: AnyObject {
    
    func dataCount() -> Int
    func dataSelectedCount() -> Int
    func dataForIndex(_ index: Int) -> CFDropDownDataSource?
    func isSelected(_ index: Int) -> Bool?

}
