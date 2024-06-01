//
//  CFButtonVariety.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

public enum CFButtonVariety: String {
    
    
    // addmore document to upload in customer
    case addMoreFile = " Add More File"
    case submit = "Submit"
    
    // deactivate warehouse
    case deactivate = "Deactivate"
    case activate = "Activate"

   // customer type
    case Disable = "Disable"
    case Enable = "Enable"
    case Changepassword = "Changepassword"
    
    // customer release dock and delivery
    case addMoreStaffs = "Add More Staffs"

    case edit = " Edit"
    case delete = " Delete"

    // for Add customer
    case addCustomer = "Add Customer"
    case addWareHouse = "Add Warehouse"
    case adddeliveryRelease = "Add Delivery Release"
    case adddockRelease = "Add Dock Release"
    case addUser = "Add User"
    case addCompany = "Add Company"
    case addReport = "Add Report"

    // for add zone
    case addZone = "Add Zone"
    case addCustomertype = "Add Customer Type"
    
    //for generate report
    case generateReport = "Generate Report"

}

extension CFButtonVariety{
    
    var buttonImage: UIImage?{
        switch self {
        case .addMoreFile, .addZone, .addMoreStaffs:
            return #imageLiteral(resourceName: "plus")
        case .edit:
            return #imageLiteral(resourceName: "editIcon")
        case .delete:
            return #imageLiteral(resourceName: "deleteIcon")
       default:
            return nil
        }
    }
    
    var gradientColors: [CGColor]{
        switch self {
        case .addMoreFile, .addZone, .addMoreStaffs:
            return [UIColor(red: 0.933, green: 0.337, blue: 0.176, alpha: 1).cgColor,
                    UIColor(red: 0.094, green: 0.345, blue: 0.91, alpha: 1).cgColor]
        default:
            return []
        }
    }
    
    var buttonFont: UIFont?{
        switch self {
        case .addMoreFile, .submit, .addMoreStaffs, .generateReport:
            return .setFont(.regular, size: .ratioWidthBasedOniPhoneX(14))
        default:
            return nil
        }
    }
    
    var backGroundColor: UIColor{
        switch self {
        case .addMoreFile, .addZone, .addMoreStaffs:
            return .clear
        case .submit, .generateReport:
            return .secondaryColor
        case .edit:
            return .appYellowColor
        case .delete, .activate:
            return .appPinkColor
        case .addCustomer, .addCustomertype, .addWareHouse, .addUser, .addCompany, .adddeliveryRelease, .adddockRelease, .addReport:
            return .primaryColor
        case .deactivate:
            return .orange
        case .Disable:
            return .orange
        case .Enable:
            return .orange
        case .Changepassword:
            return .orange
        }
    }
    
}
