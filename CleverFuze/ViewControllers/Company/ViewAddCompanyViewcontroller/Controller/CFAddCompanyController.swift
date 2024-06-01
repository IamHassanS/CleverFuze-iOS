//
//  CFAddCompanyController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import UIKit

class CFAddCompanyController: CFBaseEntryController {
  
  let viewCompanyData: CFFieldDataLoder = [0:[.companyName, .idNumber, .scacNumber, . warehouseLocation, .serviceNumber, .addressLine1,  .zip, .buttonFooter(.single(.submit))]]
     
  override init() {
    super.init()
    self.loadingData = self.viewCompanyData
    }
  }

                                              
                                
