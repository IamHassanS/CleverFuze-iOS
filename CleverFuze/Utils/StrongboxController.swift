//
//  StrongboxController.swift
//  Humm
//
//  Created by Arunkumar on 12/03/21.
//  Copyright © 2021 AIT. All rights reserved.
//

import Foundation


class StrongboxController {
    
    static let strongBox = Strongbox()
    
    class func clearSecureEnclave() {
        StrongBoxKey.allCases.forEach{ StrongboxController.strongBox.remove(key: $0.rawValue) }
    }
    
}

extension StrongboxController{
    
    static var userData: CFLoginDatum?{
        get{
            let data = try? strongBox.unarchive(CFLoginDatum.self, for: StrongBoxKey.userDetails.rawValue)
            return data
        }
        set{
            _ = try? strongBox.archive(object: newValue, key: StrongBoxKey.userDetails.rawValue)
        }
    }
    
}

extension StrongboxController{
    
    static var profileData: CFProfileViewDatum?{
        get{
            let data = try? strongBox.unarchive(CFProfileViewDatum.self, for: StrongBoxKey.profileDetails.rawValue)
            return data
        }
        set{
            _ = try? strongBox.archive(object: newValue, key: StrongBoxKey.profileDetails.rawValue)
        }
    }
    
}


extension StrongboxController {
    
    static var documentUrlData: String?{
        get{
            let data = (try? strongBox.unarchive(String.self, for: StrongBoxKey.documentUrlDataKey.rawValue))
            return data
        }
        set{
            _ = try? strongBox.archive(object: newValue, key: StrongBoxKey.documentUrlDataKey.rawValue)
        }
    }
}

enum StrongBoxKey: String, CaseIterable {
    
    case userDetails = "User_Details_strongBox_key"
    case profileDetails = "Profile_Details_strongBox_key"
    case documentUrlDataKey = "document_Url_Data_Key"

}
