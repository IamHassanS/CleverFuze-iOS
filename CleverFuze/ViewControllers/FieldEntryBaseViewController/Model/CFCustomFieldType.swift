//
//  CFCustomFieldType.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import Foundation
import UIKit

//MARK: Enum case
/// Description: - This Enum is used the load table UI ( UI based on enum ). Below cases repersen the UI of Textfield, Button etc.
///
enum CFCustomFieldType {
    
    // Header
    case customerDetails
    case customertypeDetails
    case propertyDetails
    case documentDetails
    case chartDetails
    case incomeDetails
    case reportManagement
    case charts
    case customerReleaseDelivery
    case customerReleaseDock
    case reports
    case profile
    case DocumentShow
        
    //footer
    case buttonFooter(CFCustomButtonType)
    
    //  Fields for customerDetails
    case customerType(CFScreenType?)
    case name   // Same this used for all name entry field
    case addcustomertype
    case propertyAddress
    //case addressLine2
    case city
    case state
    case zipcode
    
// Field for customer name view
    case namesz
    case customertypsz
    case lotnumberz
    case packedDateInz
    case loadDatez
    case estimatedDateOutz
    case actualDateOutz
    case intialActualWightz
    case actualWeightz
    case totalRateInz
    case zonez
    case storageRatez
    case customerRealesz
    //Report customer fields
//    case propertyLocationz
    case releaseWeightz
    case releaseDatez
    case deliveryoutRatez

    //  Fields for propertyDetails
    case propertyLocation(CFScreenType?)
    case customerstatus
    case lotNumber
    case loadDate
    case packDateIn
    case estimatedDateOut
    case actualdateout
    case estimatedWeight
    case initialActualWeight
    case actualWeight
    case zone  // Same this used for all zone entry field
    case totalRateIn
    case storageRate
    case totalHandling
    case expectedMonthsInStorage
    case overflow
    case storageVaults
    case liftVans
    case warehouse(CFScreenType?)
    case companyAndOrganization
    case estimatedIncome
    case actualIncome
    case initialStorage
    case quarterlyStorage
    case totalIncome
    case totalincomv
    case currentStorage
    case StorageReleaseIncome
    //  Fields for documentDetails
    case documentToUpload(Int)
    case fileInput(Int)
    
    // Record page
    case startDate
    case endDate

    // for list data
    case dashBoardRecordList
    
    // for lists
    case customerList
    case warehouseList
    case customertypelist
    

    case userList
    case companyList
    case deliveryList
    case dockList
    case reportlist
    case incomeList
    
    // for add zone
    case addZone
    case zoneEntry(Int) // used for add zone
    case zoneSelectAddEdit
    
    // for add warehouse
    case address
    case storageCapacity
    case size

    // for add user
    case emailAddress
    case userRole
    case password
    case NewPassword
    case confirmPasswordz
    case confirmPassword

    // for add company
    case companyName // for dock
    case companyNamez
    case idNumber
    case idNumberz
    case serviceNumber
    case serviceNumberz
    case scacNumber
    case scacNumberz
    case warehouseLocation
    case addressLine1
    case addressLine1z
    case addressLine2
    case zip
    
    // Customer
    case releaseStatus
    
    // for delivery
    case customerName
    case deliveryType
    case deliveryAddress
    case deliveryDate
    case deliveryZone
    case propertyWeight
    case deliveryoutRate
    case releaseIncome // for dock
    case damagaeMissingItems // for dock
    case staffName(Int) // for dock
    
    // for Dock
    
   case pickupCompany
   case releaseWeight
   case releaseDate(CFScreenType?)
   case handlingoutFee
       
    // Fields for reportManagement
    case from
    case to
    case userStatus
    case customerRelease
    case releasetype // for dock
    case customersname
    
   // case warehouse
    case customerzone
    
    case type
    case CustomTypename
    case screenType(CFScreenType)
    
    init(warehouseType: CFScreenType? = .add) {
        self = .warehouse(warehouseType)
    }
    init(customertype1: CFScreenType? = .add) {
        self = .customerType(customertype1)
    }
    init(propertylocation: CFScreenType? = .add) {
        self = .propertyLocation(propertylocation)
    }
    init(releaseDate1: CFScreenType? = .add) {
        self = .releaseDate(releaseDate1)
    }
    
   //#MARK: Title
    //used for show in field header or field name
    var title: String{
        switch self {
            //Header
        case .customerDetails:
            return "Customer Details (* Required Fields)"
            
        case .customertypeDetails:
            return "Customertype Details"
        case .propertyDetails:
            return "Property Details"
        case .documentDetails:
            return "Document Details"
        case .chartDetails:
            return "Chart Details"
        case .incomeDetails:
            return "Income Details"

         //header
        case .reports:
            return "Reports"
        case .reportManagement:
            return "Report Management"
        case.charts:
            return "charts"
        case .customerReleaseDelivery:
            return "customerReleaseDelivery"
        case .customerReleaseDock:
            return "customerReleaseDock"
        case .profile:
            return "Profile"
            
            // Footer
        case .buttonFooter:
            return "Button Footer"
            //  Fields for customerDetails
        case .customerType(let screenType):
            return screenType == .edit ? "Customer Type:*" : "Customer Type"
        case .warehouse(let screenType):
            return screenType == .edit ? "Warehouse:*" : "Warehouse"
        case .name:
            return "Name:*"
        case .addcustomertype:
            return "Add Customer Type:*"
        case .propertyAddress:
            return "Property Address:*"
//        case .addressLine2:
//            return "Address Line 2:"
        case .city:
            return "City:*"
        case .state:
            return "State:*"
        case .zipcode:
            return "Zipcode:*"
            
            //  Fields for propertyDetails
        case .propertyLocation(let screenType):
            return screenType == .edit ? "Property Location:*" : "Property Location"
        case .customerstatus:
            return "Customer Status:*"
        case .lotNumber:
            return "Lot Number:*"
        case .loadDate:
            return "Load Date:*"
        case .packDateIn:
            return "Pack Date In:*"
        case .actualdateout:
            return "Actual Date Out:*"
        case .estimatedDateOut:
            return "Estimated Date Out:*"
        case .estimatedWeight:
            return "Estimated Weight:(in lb)*"
        case .initialActualWeight:
            return "Initial Actual Weight:(in lb)*"
        case .actualWeight:
            return "Actual Weight:(in lb)*"
        case .zone:
            return "Zone:*"
        case .totalRateIn:
            return "Total Rate In:($)*"
        case .storageRate:
            return "Storage Rate:($)*"
        case .totalHandling:
            return "Total Handling In:($)"
        case .expectedMonthsInStorage:
            return "Expected Months In Storage:*"
        case .overflow:
            return " Overflow:"
        case .storageVaults:
            return "Storage Vaults:*"
        case .liftVans:
            return "Lift Vans:*"
        case .warehouse(let screenType):
            return screenType == .edit ? "Warehouse:*" : "Warehouse"
        case .companyAndOrganization:
            return "Company/Organization:"
        case .estimatedIncome:
            return "Estimated Income:($)"
        case .actualIncome:
            return " Actual Income:($)"
        case .initialStorage:
            return "Initial Storage:($)"
        case .quarterlyStorage:
            return "Quarterly Storage:($)"
        case .totalincomv:
            return "Total Income:($)"
        case .currentStorage:
            return "Current Storage:(in lb)"
            
            //  Fields for documentDetails
        case .documentToUpload:
            return "Document To Upload"
        case .fileInput:
            return "File Input"
            
            // Record page
        case .startDate:
            return "Start Date"
        case .endDate:
            return "End Date"
            
            // Record
        case .dashBoardRecordList:
            return "Customer Name"
            
            // customer
        case .customerList:
            return "Customer"
        case .warehouseList:
            return "Warehouse"
        case .customertypelist:
            return "Customer Type"
        
            // for add zone
        case .addZone:
            return "Add Zone"
        case .zoneEntry:
            return "Zone"
        case .zoneSelectAddEdit:
            return "Select Zone to Edit/Delete "
            
            // for add warehouse
        case .address:
            return "Address:*"
        case .storageCapacity:
            return "Storage Capacity:(in lb)*"
        case .size:
            return "Size:(in sqft.)*"
            
            // for add user
        case .userList:
            return "Customer"
            
        case .emailAddress:
            return "E-mail Address:*"
        case .userRole:
            return "User Role:*"
        case .password:
            return "Password:*"
        case .NewPassword:
            return"New Password:*"
        case .confirmPassword:
            return "Confirm Password:*"
                        
            // for add company
        case .companyList:
            return "Company"
        case .companyName:
            return "Company Name:*"
        case .idNumber:
            return "ID Number:*"
        case .serviceNumber:
            return "Service Number:"
        case .scacNumber:
            return "SCAC Number:"
        case .warehouseLocation:
            return "Warehouse Location:"
        case .addressLine1:
            return "Address Line 1:*"
        case .addressLine2:
            return "Address Line 2:"
        case .zip:
            return "ZIP:*"
            
        // report
        case .incomeList:
            return "Item name"
        case .reportlist:
            return "Customers"
        case .from:
            return "From"
        case .to:
            return "To"
        case .userStatus:
            return "User status"
        case .customerRelease:
            return "Customer Release"
        case .releasetype:
            return "Release Type"
        case .customerzone:
            return "Customer Zone"
        case .customersname:
            return "Customers Name"
            // for delivery
        case .deliveryList:
            return "Customer"
        case .customerName:
            return "Customer Name:*"
        case .deliveryType:
            return "Delivery Type:*"
        case .deliveryAddress:
            return "Delivery Address:*"
        case .deliveryDate:
            return "Delivery Date:*"
        case .deliveryZone:
            return "Delivery Zone:*"
        case .propertyWeight:
            return "Property Weight:(in lb)*"
        case .deliveryoutRate:
            return "Delivery Out Rate:($)*"
        case .releaseIncome:
            return "Release Income:($)*"
        case .damagaeMissingItems:
            return "Damage/Missing Items:"
        case .staffName:
            return "Staff Name:"
            
            
            // for dock
        case .dockList:
            return "Customer"
        case .pickupCompany:
            return "Pickup Company"
        case .releaseWeight:
            return "Release Weight:(in lb)*"
        case .releaseDate(let screenType):
            return screenType == .edit ? "Date of Release:*" : "Date of Release"
        case .handlingoutFee:
            return "Handling Out Fee:($)*"
        
            // Customer
        case .releaseStatus:
            return "Release Status"
        case .type:
           return "Type:*"
        case .totalIncome:
            return "Total income"
        case .CustomTypename:
            return "Customer Type name:*"
        case .namesz:
            return "Name"
        case .customertypsz:
            return "Customer Type"
        case .lotnumberz:
            return "Lot Number"
        case .packedDateInz:
            return "Pack Date In"
        case .loadDatez:
            return "Load Date"
        case .estimatedDateOutz:
            return "Expeted Date Out"
        case .actualDateOutz:
            return "Actual Date Out"
        case .intialActualWightz:
            return "Intial Actual Weight(lb)"
        case .actualWeightz:
            return "Actual Weight(lb)"
        case .totalRateInz:
            return "Total In Rate($)"
        case .zonez:
            return "Zone"
        case .storageRatez:
            return "Storage Rate($)"
        case .customerRealesz:
            return "Release Status"
        case .StorageReleaseIncome:
            return "Storage Release Incom($)"
        case .DocumentShow:
            return "Document Show"
        case .confirmPasswordz:
            return "Confirm Password:*"
        case .companyNamez:
            return "companyName"
        case .idNumberz:
            return "idNumber"
        case .serviceNumberz:
            return "serviceNumber"
        case .scacNumberz:
            return "scacNumber"
        case .addressLine1z:
            return "addressLine1"
//        case .propertyLocationz:
//            return "Property Location"
        case .releaseWeightz:
            return "Release Weight(lb)"
        case .releaseDatez:
            return "Released Date"
        case .deliveryoutRatez:
            return "Out rate($)"
        case .screenType:
            return ""
        }
    }
    
    //#MARK: placeholder
    //used for show in field placeholder
    var placeHolder: String {
    switch self {
        case .customerType:
            return "Select type"
        case .name:
            return "Enter name"
        case .addcustomertype:
            return "Enter Customer type"
        case .propertyAddress, .address:
            return "Enter address"
        case .city:
            return "Enter city"
        case .state:
            return "Select state"
        case .zipcode, .zip:
            return "Enter zip"
            
            //  Fields for propertyDetails
        case .propertyLocation:
            return "Property location"
    case .customerstatus:
        return "Customer Status"
        case .lotNumber:
            return "Lot number"
            
            // include for record page Also
        case .loadDate, .packDateIn, .actualdateout, .estimatedDateOut, .startDate, .endDate:
            return "DD/MM/YYYY"
        case .estimatedWeight:
            return "Estimated weight"
        case .initialActualWeight:
            return "Initial actual weight"
        case .actualWeight:
            return "Actual weight"
        case .zone, .zoneSelectAddEdit:
            return "Select zone"
        case .totalRateIn:
            return "Total rate in"
        case .storageRate:
            return "Storage rate"
        case .totalHandling:
            return "Total handling in"
        case .expectedMonthsInStorage:
            return "Expected months in storage"
        case .overflow:
            return "Overflow"
        case .storageVaults:
            return "Enter 0-30"
        case .liftVans:
            return "Enter 0-20"
        case .warehouse:
            return "Select warehouse"
        case .companyAndOrganization:
            return "Select company"
        case .estimatedIncome:
            return "Estimated income"
        case .actualIncome:
            return "Actual income"
        case .initialStorage:
            return "Initial storage"
        case .quarterlyStorage:
            return "Quarterly storage"
        case .totalIncome:
            return "Total income"
        case .currentStorage:
            return "Current storage"
            
            //  Fields for documentDetails
        case .documentToUpload:
            return "Selected document"
        case .fileInput:
            return "Choose file"

            // For header
    case .customerDetails, .customertypeDetails, .propertyDetails, .documentDetails, .DocumentShow,.chartDetails, .incomeDetails, .buttonFooter, .dashBoardRecordList, .customerList, .warehouseList, .userList, .companyList, .deliveryList, .dockList, .reportlist, .incomeList, .reports:

            return ""
            
            // for Report placeholders
        case .from:
            return "DD/MM/YYYY"
        case .to:
            return "DD/MM/YYYY"
        case .userStatus:
            return "Select status"
        case .customerRelease:
            return "Select Release"
        case .releasetype:
            return "Select Release Type"
        case .customerzone:
            return "Select Zone"
        case .reportManagement,.charts:
            return ""
        case .customersname:
            return "Select Customers"
            
            // for add zone
        case .zoneEntry:
            return "Enter Zone"
        case .addZone:
            return "Add Zone"
 
            // for add warehouse
        case .storageCapacity:
            return "Enter Storage Capacity"
        case .size:
            return "Enter Size"

            // for add user
        case .emailAddress:
            return "Enter E-mail"
        case .userRole:
            return "Select User Role"
        case .password:
            return "Password"
    case .NewPassword:
        return "New Password"
        case .confirmPassword:
            return "Confirm Password"
            
            //place holders fro delivery
        case .customerName:
            return "Select Customer"
        case .deliveryType:
            return "Select Type"
        case .deliveryAddress:
            return "Delivery Address"
        case .deliveryDate:
            return "DD/MM/YYYY"
        case .deliveryZone:
            return "Select Delivery Zone"
        case .propertyWeight, .releaseWeight:
            return "Property Weight in (lb)"
        case .deliveryoutRate:
            return "Delivery Out Rate in ($)"
        case .releaseIncome:
            return "Release Income in ($)"
        case .damagaeMissingItems:
            return "-N/A-"
        case .staffName:
            return "Staff Name"
            
            // placeholders for dock
        case .pickupCompany:
            return "Pickup Company"
        case .releaseDate:
            return "DD/MM/YYYY"
        case .handlingoutFee:
            return "Handling Out Fee:($)*"
            
            
            // for add company
        case .companyName:
            return "Enter Company Name"
        case .idNumber:
            return "ID Number"
        case .serviceNumber:
            return "Service Number"
        case .scacNumber:
            return "SCAC Number"
        case .warehouseLocation:
            return "Select Location"
        case .addressLine1:
            return "Address Line 1"
        case .addressLine2:
            return "Address Line 2:"
        case .customerReleaseDelivery, .customerReleaseDock, .profile:
            return ""
        
            // Customer
        case .releaseStatus:
            return "Release Status"
        case .customertypelist:
            return "Customer Type"
    case .type:
        return "Enter Customer Type "
    case .totalincomv:
        return "Total income"
    case .CustomTypename:
     return "Customer Type Name"
    case .namesz:
        return "CustomerName"
    case .customertypsz:
        return "Select type"
    case .lotnumberz:
        return "lotnumber"
    case .packedDateInz:
        return ""
    case .loadDatez:
        return "loadDate"
    case .estimatedDateOutz:
        return "estimatedDateOut"
    case .actualDateOutz:
        return ""
    case .intialActualWightz:
        return "intialActualWight"
    case .actualWeightz:
        return "actualWeight"
    case .totalRateInz:
        return "totalRateIn"
    case .zonez:
        return "zone"
    case .storageRatez:
        return "storageRate"
    case .customerRealesz:
        return "customerReales"
    case .StorageReleaseIncome:
        return "storage release incom"
    case .DocumentShow:
        return "DocumentShow"
    case .confirmPasswordz:
        return "Confirm Password"
    case .companyNamez:
        return "companyName"
    case .idNumberz:
        return "idNumber"
    case .serviceNumberz:
        return "serviceNumber"
    case .scacNumberz:
        return "scacNumber"
    case .addressLine1z:
        return "addressLine"
//    case .propertyLocationz:
//        return "PropertyLocation"
    case .releaseWeightz:
        return "Property Wight in(lb)"
    case .releaseDatez:
        return "DD/MM/YYYY"
    case .deliveryoutRatez:
        return "Delivery Out Rate in($)"
    case .screenType:
        return ""
    }
    }
    
    //#MARK: Title
     //used for show in field header or field name
    var uniqueValue: String{
        switch self{
        case .zoneEntry(let value):
            return "\(self.title)\(value)"
        case .fileInput((let value)):
            return "\(self.title)\(value)"
        case .documentToUpload((let value)):
            return "\(self.title)\(value)"
        case .staffName((let value)):
            return "\(self.title)\(value)"
        default:
            return self.title
        }
    }
    
    var modeImage: (left: UIImage?, right: UIImage?){
        switch self{
        case .startDate, .endDate, .loadDate, .packDateIn, .actualdateout, .estimatedDateOut:
            return (#imageLiteral(resourceName: "calendar"), nil)
        case .zone, .zoneSelectAddEdit, .state, .customerType, .customertypsz, .warehouse, .companyAndOrganization:
            return (nil, #imageLiteral(resourceName: "DropDownIcon"))
        default:
            return (nil, nil)
        }
    }
        
}

extension CFCustomFieldType{
    
    var dropDown: [CFDropDownDataSource]{
        switch self{
        case .zone, .zoneSelectAddEdit:
            return CFDropDownController.dropDownValues?.zoneTypes ?? []
        case .state:
            return CFDropDownController.dropDownValues?.states ?? []
        case .customerType:
            return CFDropDownController.dropDownValues?.customerTypes ?? []
        case .customertypsz:
            return CFDropDownController.dropDownValues?.customerTypes ?? []
        case .warehouse:
            return CFDropDownController.dropDownValues?.warehouse ?? []
        case .warehouseLocation:
            return CFDropDownController.dropDownValues?.warehouseLocation ?? []
        case .companyAndOrganization:
            return CFDropDownController.dropDownValues?.company ?? []
        case .userRole:
            return CFDropDownController.dropDownValues?.userRole ?? []
        case .userStatus:
            return CFDropDownController.dropDownValues?.userStatus ?? []
        case .customerName:
            return CFDropDownController.dropDownValues?.customers ?? []
        case .customerRelease:
            return CFDropDownController.dropDownValues?.customerRelease ?? []
        case .deliveryZone, .customerzone:
            return CFDropDownController.dropDownValues?.zoneTypes ?? []
//        MARK: Below changes for to adding customers name field  in report management :
        case .customersname:
            return CFDropDownController.dropDownValues?.customers ?? []

        case .damagaeMissingItems:
            return CFDropDownController.dropDownValues?.damagaeMissingItems ?? []
        case .releasetype, .deliveryType:
            return CFDropDownController.dropDownValues?.releaseType ?? []
        case .documentToUpload:
            return CFDropDownController.dropDownValues?.documentTypes ?? []
        default:
            return []
        }
    }
}

extension CFCustomFieldType: Hashable{
    
    static func == (lhs: CFCustomFieldType, rhs: CFCustomFieldType) -> Bool {
        return lhs.uniqueValue == rhs.uniqueValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uniqueValue)
    }
    
    
}

extension CFCustomFieldType{

    var needValidation: Bool{
        switch self{
        case .buttonFooter(_), .documentDetails, .propertyDetails, .customerDetails, .addressLine2, .overflow, .documentToUpload, .fileInput, .zoneSelectAddEdit, .addZone, .staffName(_), .companyAndOrganization:
            return false
        default:
            return true
        }
    }
    
}

extension CFCustomFieldType{

    var keyboardType: UIKeyboardType{
        switch self {
        case .emailAddress:
            return .emailAddress
        case .lotNumber, .storageCapacity, .size, .idNumber, .serviceNumber, .scacNumber, .zipcode, .propertyWeight, .deliveryoutRate, .releaseIncome, .releaseWeight, .handlingoutFee, .initialStorage, .actualdateout, .estimatedWeight, .actualWeight, .totalRateIn, .storageRate, .quarterlyStorage, .totalHandling, .storageVaults, .totalIncome, .zip, .actualIncome, .estimatedIncome, .currentStorage, .initialActualWeight, .expectedMonthsInStorage, .liftVans:
            return .numberPad
        default:
            return .default
        }
    }
}

extension CFCustomFieldType{

    var isNeedRemoveButton: Bool{
        switch self {
        case .zoneEntry(let zoneId):
            return zoneId <= 0
        case .fileInput(_):
            return false
        case .staffName(let staffId):
            return staffId <= 0
        default:
            return true
        }
    }

}

