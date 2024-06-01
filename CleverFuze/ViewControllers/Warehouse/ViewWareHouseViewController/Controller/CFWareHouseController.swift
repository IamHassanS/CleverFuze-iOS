//
//  CFWareHouseController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFWareHouseController: CFRecordController {
    
    override init() {
        super.init()
        self.endPoint = .viewWareHouse
    }
    
    override func loadData() {
        self.recordData = [0: StrongboxController.userData?.userRole == .member ? [.warehouseList] : [.buttonFooter(.single(.addWareHouse)), .warehouseList]]
    }
    
    override func callAPI() {
        super.callAPI(type: CFWareHouseResponse.self)
    }
    
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchWarehouse, type: CFWareHouseResponse.self)
        }
    }

}
