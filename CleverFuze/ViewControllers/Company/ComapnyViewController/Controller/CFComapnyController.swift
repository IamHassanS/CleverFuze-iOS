//
//  CFComapnyController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFComapnyController: CFRecordController {
    
    override init() {
        super.init()
        self.endPoint = .viewCompany
    }
    
    override func loadData() {
        self.recordData = [0:  StrongboxController.userData?.userRole == .member ? [.companyList] : [.buttonFooter(.single(.addCompany)), .companyList]]
    }
    
    override func callAPI() {
        
        super.callAPI(type: CFCompanyListResponse.self)
        
    }
        
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .searchCompany, type: CFCompanyListResponse.self)
        }
    }
    
    
}
