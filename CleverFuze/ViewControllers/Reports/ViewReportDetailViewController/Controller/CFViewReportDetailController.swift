//
//  CFViewGenerateReportController.swift
//  CleverFuze
//
//  Created by venkat subramaian on 07/09/22.
//

import UIKit

class CFViewReportDetailController: CFBaseEntryController {
    var viewCustomerData: CFFieldDataLoder = [:]
    var valued: Bool?
    override var screenType: CFScreenType?{
        didSet{
//        MARK: Below changes for to remove estimated weight and estimated income (Add, edit , view) :
            if screenType == .view{
                viewCustomerData = [0: [.namesz, .customerType(nil), .propertyLocation(.view), .lotnumberz, .packedDateInz,.intialActualWightz,.actualWeightz,.loadDatez,.customerzone, .totalRateInz, .storageRatez, .warehouse(nil), .customerRelease, .releasetype, .releaseWeightz, .releaseDate(.view), .deliveryoutRatez, .quarterlyStorage, .totalHandling,.StorageReleaseIncome,.totalincomv ]]
            }else if screenType == .edit{
                viewCustomerData = [0: [.customerDetails, .customerType(.edit), .name,.customerstatus,.releaseDate(.edit), .propertyAddress, .addressLine2, .city, .state, .zipcode],
                                    1: [.propertyDetails, .propertyLocation(nil), .lotNumber, .loadDate, .packDateIn, .estimatedDateOut, .initialActualWeight,.actualWeight, .zone, .totalRateIn, .storageRate, .totalHandling, .expectedMonthsInStorage, .overflow, .storageVaults, .liftVans, .warehouse(.edit), .companyAndOrganization, .actualIncome, .initialStorage, .quarterlyStorage, .totalIncome,.currentStorage],
                                    2: [.documentDetails, .documentToUpload(0),.fileInput(0)]]
            }else{
                viewCustomerData = [0: [.customerDetails, .customerType(nil), .name, .propertyAddress, .addressLine2, .city, .state, .zipcode],
                                    1: [.propertyDetails, .propertyLocation(nil), .lotNumber, .packDateIn, .loadDate, .estimatedDateOut, .initialActualWeight, .actualWeight, .zone, .totalRateIn, .storageRate, .totalHandling, .expectedMonthsInStorage, .overflow, .storageVaults, .liftVans, .warehouse(.edit), .companyAndOrganization, .actualIncome, .initialStorage, .quarterlyStorage, .totalIncome,.currentStorage],
                                    2: [.documentDetails, .documentToUpload(0),.fileInput(0)]]
           }
            
            if screenType == .edit, let customerRelease = (existData as? CFRecordDatum)?.customerRelease, customerRelease == "No Release"{
                // Modify the fields for the .edit screenType
                self.viewCustomerData[0]?.removeAll { $0 == .customerstatus || $0 == .releaseDate(.edit) }
            }
            self.loadingData = self.viewCustomerData
            self.setDataValues()
            if screenType == .edit{
                valued = true
            }
            
        }
    }
    
    override init() {
        super.init()
        self.screenType = nil
        self.loadingData = self.viewCustomerData
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Report")
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        super.didSetValue(data, indexPath: indexPath, field: field)
    }
  
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        super.setDataValues(customType)
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .some(.edit):
            return .updateReports(id: self.existData?.customerID ?? 1)
        case .some(.delete):
            return .deleteCustomer(id: self.existData?.customerID ?? 1)
        default:
            return nil
        }
    }
    
}
   
   
