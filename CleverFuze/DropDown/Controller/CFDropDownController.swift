//
//  CFDropDownController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

struct CFDropDownController{
    
    static var dropDownValues: CFDropDownDatum? = nil

    static func callDropDownAPI(){
        CFCommunicationController.networkRequest(endPoint: .dropdown, requestMethod: .get) { data, error, statusCode in
            if let error = error{
                debugPrint("Dropdown Api Error", error)
            }else{
                guard let data = data, let response = try? JSONDecoder().decode(CFDropDownResponse.self, from: data) else {
                    debugPrint("Dropdown Api decode Error")
                    return
                }
                self.dropDownValues = response.data

            }
        }
    }
}
