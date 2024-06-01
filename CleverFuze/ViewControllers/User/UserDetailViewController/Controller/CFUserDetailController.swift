//
//  CFUserDetailController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFUserDetailController: CFBaseEntryController {
    
    var viewUserData: CFFieldDataLoder = [:]{
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
            self.setdata()
            self.changedata()
        }
    }
    
    override var existData: CFRecordDataSource?{
        didSet{
            self.setdata()
            self.changedata()
        }
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit || buttonType == .delete{
            self.detailsModifyAPI("User")
        }else{
            debugPrint("Nothing to action")
        }
    }
    
    override func endPoint() -> CFEndPoint? {
        switch self.screenType {
        case .some(.delete):
            return .deleteUser(id: self.existData?.id ?? 0)
        case .some(.edit):
            return .updateUser(id: self.existData?.id ?? 0)
        case .add:
            return .addUser
        case .Changepassword:
            return .ChangePassword(id:  self.existData?.id ?? 0)
        default:
            return nil
        }
    }
    override func postBody() -> [String: Any]{
        var params = [String: Any]()
        self.existLoadedData.forEach { (field, value) in
            if let key = field.keysForUser{
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

extension CFUserDetailController{
    
    func setdata(){
        switch screenType{
        case .add:
            self.viewUserData =  [0: [.name, .emailAddress, .userRole, .password, .confirmPassword, .buttonFooter(.single(.submit))]]
        case.edit:
            self.viewUserData = [0: [.name, .emailAddress, .userRole, .buttonFooter(.single(.submit))]]
        default:
            self.viewUserData = [0: [.name, .emailAddress, .userRole, (self.existData as? CFUsersDatum)?.email == StrongboxController.profileData?.email ? .buttonFooter(.single(.edit)) : .buttonFooter(.double(left: .edit, right: .delete)),.buttonFooter(.single(.Changepassword))]]
        }
          
      }
    
}
extension CFUserDetailController{
    func changedata(){
        switch screenType{
        case .Changepassword:
            self.viewUserData =  [0: [.name, .emailAddress, .userRole, .NewPassword, .confirmPasswordz, .buttonFooter(.single(.submit))]]
        default:
            break
        }
    }
}
