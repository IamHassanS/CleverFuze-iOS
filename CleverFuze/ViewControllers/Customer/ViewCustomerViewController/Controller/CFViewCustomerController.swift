//
//  CFViewCustomerController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFViewCustomerController: CFRecordController {

    override init() {
        super.init()
        self.endPoint = .viewCustomer
    }
    
    override func loadData() {
        self.recordData = [0:  StrongboxController.userData?.userRole == .member ? [.customerList] : [.buttonFooter(.single(.addCustomer)), .customerList]]
    }
    
    func searchFieldDidSearch(_ string: String, completion: @escaping () -> Void) {
            if string.isEmpty {
                self.callAPI()
            } else {
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    completion()
                }
            }
        }

    override func callAPI() {
        super.callAPI(type: CFRecordResponse.self)
    }
}
