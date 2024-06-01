//
//  File.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

struct CFAuthRequestModel {
  
  var email : String?
  var password : String?

  /**
   * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
   */
  func toDictionary() -> [String:Any]{
    var dictionary = [String:Any]()
    if email != nil{
      dictionary["email"] = email
    }
    if password != nil{
      dictionary["password"] = password
    }

    return dictionary
  }
}
