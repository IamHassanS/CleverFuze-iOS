//
//  CFUsersController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFUsersController: CFRecordController {
    
    override init() {
        super.init()
        self.endPoint = .viewUser
    }
    
    override func loadData() {
        self.recordData = [0: [.buttonFooter(.single(.addUser)), .userList]]
    }
    
    override func callAPI() {
        
        super.callAPI(type: CFUsersResponse.self)
        
    }
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchUser, type: CFUsersResponse.self)
        }
    }
    
}
