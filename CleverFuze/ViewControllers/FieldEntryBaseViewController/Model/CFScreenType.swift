//
//  CFScreenType.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import Foundation

enum CFScreenType: String{
    
    case edit = "Updated"
    case view
    case add = "Added"
    case delete = "Deleted"
    case activated = "Activate"
    case deActivated = "Deactivate"
    case Disable = "Disable"
    case Enable = "Enable"
    case Changepassword = "Changepassword"

}

extension CFScreenType{
    
    var isEditable: Bool{
        return self != .view
    }
    
}
