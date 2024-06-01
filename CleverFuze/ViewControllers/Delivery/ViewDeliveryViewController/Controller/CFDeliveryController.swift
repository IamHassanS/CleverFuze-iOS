//
//  CFDeliveryController.swift
//  CleverFuze
//
//  Created by AnilKumar on 31/08/22.
//

import UIKit

class CFDeliveryController: CFRecordController {

    override init() {
        super.init()
        self.endPoint = .viewDelivery
    }
    
    override func loadData() {
        self.recordData = [0: [.buttonFooter(.single(.adddeliveryRelease)), .deliveryList]]
    }

    override func callAPI() {
        super.callAPI(type: CFDeliveryAndDockResponse.self)
    }
    
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchDelivery, type: CFDeliveryAndDockResponse.self)
        }
    }
}

