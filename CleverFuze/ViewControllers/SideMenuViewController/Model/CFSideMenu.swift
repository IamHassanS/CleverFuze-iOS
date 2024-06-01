//
//  CFSideMenu.swift
//  The_Travel_App
//
//  Created by Anil Kumar on 07/07/22.
//  Copyright © 2022 AIT. All rights reserved.
//

import Foundation
import UIKit

enum CFSideMenu {
    
    case dashBoard
    case customer
    case customertype
    case wareHouse
    case company
    case zone
    case customerReleaseDelivery
    case customerReleaseDock
    case user
    case reports
    
    var image: UIImage{
        switch self {
        case .dashBoard:
            return #imageLiteral(resourceName: "sideMenuDashBoard")
        case .customer:
            return #imageLiteral(resourceName: "sideMenuCustomer")
        case .customertype:
            return #imageLiteral(resourceName: "sideMenuCustomer")
        case .wareHouse:
            return #imageLiteral(resourceName: "sideMenuWareHouse")
        case .company:
            return #imageLiteral(resourceName: "sideMenuCompany")
        case .zone:
            return #imageLiteral(resourceName: "sideMenuZone")
        case .user:
            return #imageLiteral(resourceName: "sideMenuUsers")
        case .reports:
            return #imageLiteral(resourceName: "sideMenuFile")
        case .customerReleaseDelivery, .customerReleaseDock:
            return #imageLiteral(resourceName: "sideMenuCustomerRelease")
        }
        
    }
    
    var title: String{

        switch self {
        case .dashBoard:
            return "DashBoard"
        case .customer:
            return "Customer"
        case .customertype:
            return "Customer Type"
        case .wareHouse:
            return "Ware House"
        case .company:
            return "Company"
        case .zone:
            return "Zone"
        case .user:
            return "Users"
        case .reports:
            return "Reports"
        case .customerReleaseDelivery:
            return "Customer Release - Delivery"
        case .customerReleaseDock:
            return "Customer Release - Dock"
        }
    }
    
}

extension CFSideMenu: Hashable{
    
    static func ==(_ lhs: Self, _ rhs: Self) -> Bool{
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title.hashValue)
    }
    
}

extension CFSideMenu{
    
    static var menuBasedRole: [Self]{
        switch StrongboxController.userData?.userRole{
        case .none, .some(.member):
            return [.customer, .wareHouse, .company]
        case .some(.admin):
            return [.dashBoard, .customer, .customertype, .wareHouse, .zone, .company, .customerReleaseDelivery, .customerReleaseDock, .user, .reports]
        case .manager:
            return [.customer, .wareHouse, .company, .customerReleaseDelivery, .customerReleaseDock]
        }
    }
    
}
