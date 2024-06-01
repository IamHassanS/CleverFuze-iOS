//
//  CustomerTypeController.swift
//  CleverFuze
//
//  Created by AIT MAC on 8/31/23.
//

import Foundation
class CustomerTypeController: CFRecordController {
    
    override init() {
        super.init()
        self.endPoint = .viewCustomertype
       }
    
    override func loadData() {
        self.recordData = [0: [.buttonFooter(.single(.addCustomertype)), .customertypelist]]
    }
    
    override func callAPI() {
        super.callAPI(type: CFCustomerTypeResponse.self)
    }
    
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchCustomertype, type: CFCustomerTypeResponse.self)
        }
    }

}

