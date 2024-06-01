//
//  CFCompanyDetailController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFCompanyDetailController: CFBaseEntryController {
    
//    let viewCompanyData: CFFieldDataLoder = [0: [.companyName, .idNumber, .serviceNumber, .scacNumber, .warehouseLocation, .addressLine1, .addressLine2, .city, .state, .zip]]
    var valued: Bool?
    var viewCompanyData: CFFieldDataLoder = [:]
    override var screenType: CFScreenType?{
        didSet{
            if screenType == .view{
                viewCompanyData = [0: [.companyNamez,.addressLine1z,.idNumberz,.serviceNumberz,.scacNumberz]]
            }else if screenType == .edit{
                viewCompanyData = [0: [.companyName, .idNumber, .serviceNumber, .scacNumber, .warehouseLocation, .addressLine1, .addressLine2, .city, .state, .zip]]
            }else if screenType == .add{
                viewCompanyData = [0: [.companyName, .idNumber, .serviceNumber, .scacNumber, .warehouseLocation, .addressLine1, .addressLine2, .city, .state, .zip]]
            }
            self.loadingData = self.viewCompanyData
            self.setDataValues()
            if screenType == .edit{
                valued = true
            }
        }
    }
    override init() {
        super.init()
        self.loadingData = self.viewCompanyData
        
    }


    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .some(.edit):
            return .updateCompany(id: self.existData?.id ?? 0)
        case .some(.add):
            return .addCompany
        case .some(.delete):
            return .deleteCompany(id: self.existData?.id ?? 0)
        default:
            return nil
        }
    }
    
    override func postBody() -> [String: Any] {
            var params = [String: Any]()
            self.existLoadedData.forEach { (field, value) in
                if let key = field.keysForCompany {
                    if let stringValue = (value as? String), stringValue.isEmpty {
                        params[key] = ""
                    } else {
                        if let dropDownValue = value as? CFDropDownDataSource {
                            params[key] = dropDownValue.id ?? dropDownValue.name ?? ""
                        } else {
                            params[key] = value as? String ?? ""
                        }
                    }
                }
            }
            return params
        }
    
}

 
