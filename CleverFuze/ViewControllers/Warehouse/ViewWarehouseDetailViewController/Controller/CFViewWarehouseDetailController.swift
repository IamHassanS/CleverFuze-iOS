
//
//  CFViewWarehouseDetailController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFViewWarehouseDetailController: CFBaseEntryController {
    
    let viewWarehouseData: CFFieldDataLoder = [0: [.name, .address, .storageCapacity, .size]]
        
    override init() {
        super.init()
        self.loadingData = self.viewWarehouseData
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Warehouse")
        }else if buttonType == .activate || buttonType == .deactivate{
            self.activateAndDeactivate(buttonType)
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        super.setDataValues()
        if self.screenType == .view, let status = (self.existData as? CFWareHouseDatum)?.status, StrongboxController.userData?.userRole == .admin {
            self.addTheFieldsInLast(.buttonFooter(.single(status == .activate ? .activate : .deactivate)))
        }
    }
    
    
    override func postBody() -> [String: Any]{
        var params = [String: Any]()
        self.existLoadedData.forEach { (field, value) in
            if let key = field.keysForWarehouse{
                params[key] = value
            }
        }
        return params
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .delete:
            return .deleteWarehouse(id: self.existData?.id ?? 0)
        case .none, .view:
            return nil
        case .some(.edit):
            return .updateWareHouse(id: self.existData?.id ?? 0)
        case .some(.add):
            return .addWareHouse
        case .some(.deActivated), .some(.activated):
            return .deactivateWarehouse(id: self.existData?.id ?? 0)
        case .some(.Disable):
            return nil
        case .some(.Enable):
            return nil
        case .some(.Changepassword):
            return nil
        }
    }
    
}

extension CFViewWarehouseDetailController{
    
    func activateAndDeactivate(_ buttonType: CFButtonVariety?){
        
        if buttonType == .activate{
            self.screenType = .activated
        }else if buttonType == .deactivate {
            self.screenType = .deActivated
        } else {
            self.screenType = .deActivated
        }
        guard let delegate = self.delegate else {
            return
        }
        delegate.loadingView.setLoadingScreen(view: delegate.view)
        CFCommunicationController.networkRequest(endPoint: .deactivateWarehouse(id: self.existData?.id ?? 0), requestMethod: .get, params: nil, postBody: nil) { response in
            self.addEditResponseHandler(response, with: "Warehouse")
        }

    }
    
}


