//
//  CFSideMenuController.swift
//  furthr
//
//  Created by AITMAC6 on 30/03/21.
//  Copyright © 2020 AIT. All rights reserved.
//

import UIKit

class CFSideMenuController: NSObject {
    
    var arrayOfList: [CFSideMenu]! = CFSideMenu.menuBasedRole
    var selectedIndexPath: IndexPath! = IndexPath(row: 0, section: 0)
    
    deinit {
        self.arrayOfList = nil
    }
            
}

extension CFSideMenuController{
    
    func viewController(_ menu: CFSideMenu) -> UIViewController.Type{
        switch menu {
        case .dashBoard:
            return CFHomeDashBaordViewController.self
        case .customer:
            return CFViewCustomerViewController.self
        case .customertype:
            return CFCustomerTypeViewController.self
        case .wareHouse:
            return CFViewWareHouseViewController.self
        case .company:
            return CFCompanyViewController.self
        case .zone:
            return CFAddZoneViewController.self
        case .customerReleaseDelivery:
            return CFDeliveryViewController.self
        case .customerReleaseDock:
            return CFDockViewController.self
        case .user:
            return CFUsersViewController.self
        case .reports:
            return CFReportViewController.self
        
        }
        
    }
    
}
