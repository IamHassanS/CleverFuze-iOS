//
//  Extension + UserDefault.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation


extension UserDefaults {
  
  private static var token = "persona_token"
  
  static var logintoken: String{
      set{
        standard.set(newValue, forKey: token)
      }
      get{
        return standard.string(forKey: token)!
      }
    }

}
