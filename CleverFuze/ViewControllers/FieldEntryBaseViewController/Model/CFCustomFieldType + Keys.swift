//
//  CFCustomFieldType + Keys.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/09/22.
//

import Foundation

extension CFCustomFieldType{
    
    // Keys used for warehouse add and update API
    var keysForWarehouse: String?{
        
        switch self{
        case .name:
            return "warehousename"
        case .address:
            return "warehouseaddress"
        case .storageCapacity:
            return "warehousestorage_capacity"
        case .size:
            return "warehousesize"
        default:
            return nil
        }
    }
    
    
    // Keys used for warehouse add and update API
    var keysForCustomer: String?{
        
        switch self{
        case .customerType:
            return "customerType"
        case .type:
            return "type"
        case .CustomTypename:
            return "type"
        case .name:
            return "customerName"
        case .propertyAddress:
            return "customerAddress"
        case .city:
            return "customerCity"
        case .state:
            return "customerState"
        case .zipcode:
            return "customerZip"
        case .propertyLocation:
            return "propertyLocation"
        case .customerstatus:
            return  "customerstatus"
        case .lotNumber:
            return "lotNumber"
        case .loadDate:
            return "loadDate"
        case .packDateIn:
            return "packDatein"
        case .actualdateout:
            return "actualDataout"
        case .estimatedDateOut:
            return "estimatedDateout"
        case .estimatedWeight:
            return "estimatedWeight"
        case .initialActualWeight:
            return "initialWeight"
        case .actualWeight:
            return "actualWeight"
        case .zone:
            return "zone"
        case .totalRateIn:
            return "totalRatein"
        case .storageRate:
            return "storageRate"
        case .expectedMonthsInStorage:
            return "expectedMonthstorage"
        case .storageVaults:
            return "storageValues"
        case .liftVans:
            return "liftWanes"
        case .warehouse:
            return "warehouse"
        case .documentToUpload(let index):
            return "customerFile_\(index + 1)"
        case .fileInput(let index):
            return "documentType_\(index + 1)"
        case .actualIncome:
            return "actualIncome"
        case .initialStorage:
            return "initialStorage"
        case .quarterlyStorage:
            return "quarterlyStorage"
        case .totalIncome:
            return "total_income"
        case .companyAndOrganization:
            return "company"
        case .overflow:
            return "overflow"
        case .addressLine2:
            return "customerAddress2"
        case .totalHandling:
            return "handling_in"
        default:
            return nil
        }
        
    }
    
    var keysForCompany: String?{
        
        switch self{
        case .companyName:
            return "companyName"
        case .idNumber:
            return "idNumber"
        case .serviceNumber:
            return "serviceNumber"
        case .scacNumber:
            return "scacNumber"
        case .warehouseLocation:
            return "warehouseLocation"
        case .addressLine1:
            return "companyAddress"
        case .addressLine2:
            return "companyAddress2"
        case .city:
            return "companyCity"
        case .state:
            return "companyState"
        case .zip:
            return "companyZip"
        default:
            return nil
        }
    }
    var keysForUser: String?{
        switch self{
        case .name:
            return "userName"
        case .emailAddress:
            return "userEmail"
        case .userRole:
            return "userRole"
        case .password:
            return "userPassword"
        case.NewPassword:
            return "newpassword"
        case.confirmPasswordz:
            return "confirmpassword"
        case .confirmPassword:
            return "userPassword_confirmation"
        default:
            return nil
        }
    }
    var keysForDelivery: String?{
        
        switch self{
        case .customerName:
            return "customer_id"
        case .deliveryType:
            return "delivery_type"
        case .deliveryAddress:
            return "delivery_address"
        case .deliveryDate:
            return "delivery_date"
        case .deliveryZone:
            return "delivery_zone"
        case .propertyWeight:
            return "property_weight"
        case .deliveryoutRate:
            return "deliveryout_rate"
        case .releaseIncome:
            return "release_income"
        case .damagaeMissingItems:
            return "damage_missing"
        case .staffName:
            return "staff_name"
        case .fileInput(_):
            return "missingFile"
        default:
            return nil
        }
    }
    
    var keysForDock: String?{
        
        switch self{
        case .pickupCompany:
            return "company_pickup"
        case .releaseWeight:
            return "property_weight"
        case .releaseDate:
            return "release_date"
        case .handlingoutFee:
            return "handlingout_fee"
        case .customerName:
            return "customer_id"
        case .releasetype:
            return "delivery_type"
        case .companyAndOrganization:
            return "company_id"
        case .releaseIncome:
            return "release_income"
        case .damagaeMissingItems:
            return "damage_missing"
        case .fileInput(_):
            return "missingFile"
        case .staffName:
            return "staff_name"
        default:
            return nil
        }
    }
    
    var keysForAddZone: String?{
        
        switch self{
        case .zoneEntry:
            return "caption"
        default:
            return nil
        }
        
    }
    
    var keysForReport: String?{
        
        switch self{
        case .from:
            return "reportFrom"
        case .to:
            return "reportTo"
        case .userStatus:
            return "customer_status"
        case  .customerRelease:
            return "customer_release"
        case .releasetype:
            return "release_type"
        case .warehouse:
            return "customer_warehouse"
        case .customerzone:
            return "customer_zone"
        case.customersname:
            return "customer_select"
        default:
            return nil
        }
    }
    
}
