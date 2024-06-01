//
//  CFLoginController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import Foundation

class CFLoginController: NSObject {
    
    weak var delegate: CFLoginDelegate?
    
    @discardableResult
    func validate(_ credentials: CFAuthRequestModel?) -> String?{
        
        if credentials?.email?.isEmpty ?? true{
            return ErrorData.emptyEmail.rawValue
        }
        if !(credentials?.email?.isValidEmail ?? false){
            return ErrorData.invalidEmailID.rawValue
        }
        if credentials?.password?.isEmpty ?? true{
            return ErrorData.emptyPassword.rawValue
        }
        return nil
        
    }
    
    func login(credentials: CFAuthRequestModel?){
        
        if let error = self.validate(credentials){
            self.delegate?.apiFailure(error)
            return
        }
        self.apiLoginCall(credentials: credentials)
    }
    
    func apiLoginCall(credentials: CFAuthRequestModel?){
        CFCommunicationController.networkRequest(endPoint: .login, requestMethod: .post, postBody: credentials?.toDictionary()) { [weak self] (data, error, responseCode) in
            if let error = error{
                self?.delegate?.apiFailure(error)
            }else{
                guard let data = data, let reponse = try? JSONDecoder().decode(CFLoginResponse.self, from: data) else{
                    self?.delegate?.apiFailure(CFErrorMessage.defaultError)
                    return
                }
                print(reponse)
                if let error = reponse.error{
                    self?.delegate?.apiFailure(error)
                }else{
                    UserDefaults.isFirstTime = true
                    StrongboxController.userData = reponse.data
                    self?.delegate?.apiSucess()
                }
            }
        }
        
    }
    
}
  
