//
//  CFDockController.swift
//  CleverFuze
//
//  Created by AnilKumar on 01/09/22.
//

import UIKit

class CFDockController: CFRecordController {

    override init() {
        super.init()
        self.endPoint = .viewDock
    }
    
    override func loadData() {
        self.recordData = [0: [.buttonFooter(.single(.adddockRelease)), .dockList]]
    }

    override func callAPI() {
        super.callAPI(type: CFDeliveryAndDockResponse.self)
        
    }

    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchDock, type: CFDeliveryAndDockResponse.self)
        }
    }
    
}
