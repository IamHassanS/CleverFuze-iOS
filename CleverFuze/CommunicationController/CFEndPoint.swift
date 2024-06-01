//
//  CFEndPoint.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import Foundation

enum CFEndPoint{
    
    private static let infoDic = Bundle.main.infoDictionary
    
    private static let baseURL: String = infoDic?["BaseURL"] as? String ?? ""
    
    var url: String{
        return Self.baseURL + self.rawValue
    }
    
    case login
    case dashboard
    case filter
    
    // Profile
    case editProfile
    case viewProfile
        
    // For dashboard Records
    case totalRecords
    case activerecords
    case dashboardPriorWeek
    case dashboardPriorMonth
    case dashboardCurrentYear
    
    // case for customer API
    case viewCustomer
    case updateCustomer(id: Int)
    case addCustomer
    case searchCustomer
    case deleteCustomer(id: Int)
    case warehouseCalc
    
    // case for customertype API
    case viewCustomertype
    case updateCustomertype(id : Int)
    case addCustomertype
    case searchCustomertype
    case EnableCustomerType(id : Int)
    
    
    // case for wareHouse API
    case viewWareHouse
    case updateWareHouse(id: Int)
    case addWareHouse
    case searchWarehouse
    case deleteWarehouse(id: Int)
    case deactivateWarehouse(id: Int)

    // case for users API
    case viewUser
    case updateUser(id: Int)
    case addUser
    case searchUser
    case deleteUser(id: Int)
    case ChangePassword(id:Int)
    
    // case for viewdelivery
    case viewDelivery
    case updateDelivery(id: Int)
    case addDelivery
    case searchDelivery
    case deleteDelivery(id: Int)

    // case for viewdock
    case viewDock
    case updateDock(id: Int)
    case addDock
    case searchDock
    case deleteDock(id: Int)

    // case for company API
    case viewCompany
    case updateCompany(id: Int)
    case addCompany
    case searchCompany
    case deleteCompany(id: Int)

    // Drop down
    case dropdown

    // case for zone API
    case addZone
    case updateZone(id: Int)
    case zoneDelete(id: Int)
    
    // case for report
    case viewreport
    case updateReports(id: Int)
    case reportsDelete(id: Int)
    case forgot
    
    case fullAndPartial
    
    private var rawValue: String{
        switch self {
        case .login:
            return "login"
        case .dashboard:
            return "dashboard"
        case .filter:
            return "filter"
            
            // Profile
        case .editProfile:
            return "edit/profile"
        case .viewProfile:
            return "view/profile"

        // For dashboard Records
        case .totalRecords:
            return "dashboard/totalrecords"
        case .activerecords:
            return "dashboard/activerecords"
        case .dashboardPriorWeek:
            return "dashboard/priorweek"
        case .dashboardPriorMonth:
            return "dashboard/priormonth"
        case .dashboardCurrentYear:
            return "dashboard/currentyear"
        
        // case for customer API
        case .viewCustomer:
            return "viewcustomer"
        case .updateCustomer(let id):
            return "customer/\(id)/update"
        case .addCustomer:
            return "addcustomer"
        case .searchCustomer:
            return "search"
        case .deleteCustomer(let id):
            return "customer/\(id)/delete"
            
            
            // case for customertype API
        case .viewCustomertype:
            return "customertype"
        case .updateCustomertype(let id):
            return "edit/customertype/\(id)"
        case .addCustomertype:
            return "add/customertype"
        case .searchCustomertype:
            return "customertype?search_customertype"
        case .EnableCustomerType(let id):
            return "delete/customertype/\(id)"
            
            
            
        
        // case for wareHouse API
        case .viewWareHouse:
            return "viewwarehouse"
        case .updateWareHouse(let id):
            return "warehouse/\(id)/update"
        case .addWareHouse:
            return "addwarehouse"
        case .searchWarehouse:
            return "warehouse/search"
        case .deleteWarehouse(let id):
            return "warehouse/\(id)/delete"
        case .deactivateWarehouse(let id):
            return "warehouse/\(id)/deactivate"

        // case for users API
        case .viewUser:
            return "viewuser"
        case .updateUser(let id):
            return "user/\(id)/update"
        case .addUser:
            return "adduser"
        case .searchUser:
            return "user/search"
        case .deleteUser(let id):
            return "user/\(id)/delete"
        case .ChangePassword(let id):
            return "changepassword/\(id)"
        // case for viewdelivery
        case .viewDelivery:
            return "deliveryrelease/view"
        case .updateDelivery(let id):
            return "deliveryrelease/\(id)/update"
        case .addDelivery:
            return "deliveryrelease"
        case .searchDelivery:
            return "deliveryrelease/search"
        case .deleteDelivery(let id):
            return "deliveryrelease/\(id)/delete"
            
        // case for viewdock
        case .viewDock:
            return "dockrelease/view"
        case .updateDock(let id):
            return "dockrelease/\(id)/update"
        case .addDock:
            return "dockrelease"
        case .searchDock:
            return "dockrelease/search"
        case .deleteDock(let id):
            return "dockrelease/\(id)/delete"
            
        // case for company API
        case .viewCompany:
            return "viewcompany"
        case .updateCompany(let id):
            return "company/\(id)/update"
        case .addCompany:
            return "addcompany"
        case .searchCompany:
            return "company/search"
        case .deleteCompany(let id):
            return "company/\(id)/delete"

        // Drop down
        case .dropdown:
            return "dropdown"

        // case for zone API
        case .addZone:
            return "addzone"
        case .updateZone(let id):
            return "addzone/\(id)"
        case .zoneDelete(let id):
            return "zone/\(id)/delete"
            
        // case for report API
        case .viewreport:
            return "report/data"
        case .reportsDelete(let id):
            return "customer/\(id)/delete"
        case .updateReports(let id):
            return "report/data"
        case .forgot:
            return "forgot"
            
        case .warehouseCalc:
            return "warehouse/calc"
            
        case.fullAndPartial:
            return "customer/check_actual_weight"
        }
    }
}
