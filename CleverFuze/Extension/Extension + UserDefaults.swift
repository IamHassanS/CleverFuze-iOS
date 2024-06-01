//
//  Extension + UserDefaults.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

extension UserDefaults{
    
    static private let loginKey = "login_key"
    private static var saveDocumentData = "save_Document_Data"
    
    static var isFirstTime: Bool{
        get{
            return self.standard.bool(forKey: loginKey)
        }
        set{
            self.standard.set(newValue, forKey: loginKey)
        }
    }
    
    static var saveUserDocument: String?{
        get{
            return self.standard.string(forKey: saveDocumentData) ?? ""
        }
        set{
            self.standard.set(newValue, forKey: saveDocumentData)
        }
    }
    
}
