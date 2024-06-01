//
//  CustomerTypeDetailViewController.swift
//  CleverFuze
//
//  Created by AIT MAC on 8/31/23.
//

import Foundation
class CustomerTypeDetailController: CFBaseEntryController {
    var isCustomerTypeEnabled: Bool = true
    var viewUserData: CFFieldDataLoder = [0: [.CustomTypename]]{
        didSet{
            self.loadingData = self.viewUserData
            self.delegate?.apiSucess()
        }
    }
    
    override init() {
        super.init()
        self.loadingData = self.viewUserData
    }
    
    override var screenType: CFScreenType?{
        didSet{
            self.setdata1()
        }
    }

    override var existData: CFRecordDataSource?{
        didSet{
            self.setdata1()
        }
    }
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("Customer Type")
        }else if buttonType == .Disable || buttonType == .Enable{
            self.EnableAndDisable(buttonType)
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType{
        case .some(.Disable),.some(.Enable):
            return .deactivateWarehouse(id: self.existData?.id ?? 0)
        case .some(.edit):
            return .updateCustomertype(id: self.existData?.id ?? 0)
        case .add:
            return .addCustomertype
        default:
            return nil
        }
    }
    
    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        super.setDataValues()
        if self.screenType == .view, let status = (self.existData as? CFCustomerTypeDatum)?.status, StrongboxController.userData?.userRole == .admin {
            self.addTheFieldsInLast(.buttonFooter(.single(status == .Enable ? .Enable : .Disable)))
        }
    }
    override func postBody() -> [String: Any]{
        var params = [String: Any]()
        self.existLoadedData.forEach { (field, value) in
            if let key = field.keysForCustomer{
                params[key] = (value as? CFDropDownDataSource)?.id ?? (value as? CFDropDownDataSource)?.name ?? (value as? String ?? "")
            }
        }
        return params
    }
    
    override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        if [.emailAddress, .userRole].contains(field ?? .name), (self.existData as? CFUsersDatum)?.email == StrongboxController.profileData?.email, self.screenType == .edit{
            return (false, true)
        }else{
            return super.fieldEditable(field)
        }
    }

}

extension CustomerTypeDetailController{
    
    func setdata1() {
        switch screenType {
        case .add:
            self.viewUserData =  [0: [.type, .buttonFooter(.single(.submit))]]
        case.view:
            self.viewUserData = [0:[.CustomTypename,.buttonFooter(.double(left: .edit, right: (self.existData as? CFCustomerTypeDatum)?.isActive == 1 ? .Disable : .Enable))]]
        default:
            break
        }
    }

}


extension CustomerTypeDetailController{
    func EnableAndDisable(_ buttonType: CFButtonVariety?){
        
        if buttonType == .Enable{
            self.screenType = .Enable
        }else if buttonType == .Disable {
            self.screenType = .Disable
        }else{
            self.screenType = .Disable
        }
        guard let delegate = self.delegate else{
            return
        }
        delegate.loadingView.setLoadingScreen(view: delegate.view)
        CFCommunicationController.networkRequest(endPoint: .EnableCustomerType(id: self.existData?.id ?? 0), requestMethod: .post, params: nil, postBody: nil) { response in
            self.addEditResponseHandler(response, with: "Customer Type")
        }
    }
    
    
    
}
