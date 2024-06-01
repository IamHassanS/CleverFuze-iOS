//
//  CFProfileController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 08/10/22.
//

import UIKit

class CFProfileController: NSObject {

    weak var delegate: CFBaseDelegate?
        
    static func getProfileData(){
        
        CFCommunicationController.networkRequest(endPoint: .viewProfile, requestMethod: .get) { (data, error, statusCode) in

            guard let data = data else{
                return
            }
            let dataResponse = try? JSONDecoder().decode(CFProfileResponse.self, from: data)
            StrongboxController.profileData = dataResponse?.data?.profile
            NotificationCenter.default.post(name: .profileLoad, object: nil)
        }
        
    }
    
}
