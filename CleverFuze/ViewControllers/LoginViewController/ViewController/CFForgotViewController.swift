//
//  CFForgotViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 05/10/22.
//

import Foundation
import UIKit

class CFForgotViewController: CFBaseViewController, UITextFieldDelegate{
    
    lazy var Views: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        View.backgroundColor = .clear
        return View
    }()

    lazy var forgotLabel: UILabel! = {
        let forgot = UILabel()
        forgot.translatesAutoresizingMaskIntoConstraints = false
        forgot.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
        forgot.text = "You forgot your password? Here you can easily retrieve a new password."
        forgot.textColor = .white
        forgot.textAlignment = .center
        forgot.numberOfLines = 0
        return forgot
    }()
    
    lazy var signPasswordButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Send Password Reset Link", for: .normal)
        button.titleLabel?.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(12))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondaryColor
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.addTarget(self, action: #selector(self.signbuttonAction(_:)), for: .touchUpInside)
        return button
        
    }()
    
    
    lazy var forgetEmailTextfield : UITextField = {
        
        let textField = CFLoginTextField()
        textField.padding = .init(top: 0, left: .ratioHeightBasedOniPhoneX(26), bottom: 0, right: .ratioHeightBasedOniPhoneX(26))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black.withAlphaComponent(0.3)
        textField.textAlignment = .left
        textField.textColor = UIColor.white
        textField.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(15))
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)])
        return textField
        
    }()
    var emailID:String?
    
    lazy var modelController: CFLoginController? = CFLoginController()
    
    override func loadView() {
        super.loadView()
        self.backGroundImageView.image = UIImage(named: "signInBackgroundImage")
        self.addHeaderView()
        self.modelController?.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
        navigationItem.hidesBackButton = false
        
        self.enableBackButton()
        self.headerView.rightButton.isHidden = true
        self.headerView.labelTitle.text = "Forgot Password"
        
    }
    
    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailID = textField.text
    }
}



extension CFForgotViewController{
    
    
    
    func setConstraints() {
        
        view.addSubview(Views)
        self.Views.addSubview(forgotLabel)
        self.Views.addSubview(signPasswordButton)
        self.Views.addSubview(forgetEmailTextfield)
        NSLayoutConstraint.activate([
            
            self.Views.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor),
            self.Views.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor),
            self.Views.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            self.Views.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor),
            
            self.forgotLabel.leadingAnchor.constraint(equalTo: Views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(40)),
            self.forgotLabel.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.forgotLabel.topAnchor.constraint(equalTo: Views.topAnchor, constant: .ratioHeightBasedOniPhoneX(100)),
            self.forgotLabel.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(300)),
            
            self.forgetEmailTextfield.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.forgetEmailTextfield.topAnchor.constraint(equalTo: forgotLabel.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(27)),
            self.forgetEmailTextfield.leadingAnchor.constraint(equalTo: Views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(20)),
            self.forgetEmailTextfield.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(52)),
            
            self.signPasswordButton.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.signPasswordButton.topAnchor.constraint(equalTo: forgetEmailTextfield.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(50)),
            self.signPasswordButton.leadingAnchor.constraint(equalTo: Views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(20)),
            self.signPasswordButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(52)),
        ])
        
        
    }
    
    
}

extension CFForgotViewController{
    struct APIResponse: Codable {
        let status: Bool
        let message: String
    }

    func postBody() -> [String: Any]{
        let params = ["email": self.emailID ?? ""]
        return params
    }
    
    @objc private func signbuttonAction(_ sender: UIButton){
        apiCall()
    }
    func apiCall() {
        self.loadingView.setLoadingScreen(view: self.view)
        CFCommunicationController.networkRequest(endPoint: .forgot, postBody: self.postBody()) { data, error, responseCode in
            DispatchQueue.main.async {
                self.loadingView.removeLoadingScreen()
            }

            if let error = error {
                print(error, "error::::")
                self.showErrorAlert("API Request Failed")
                debugPrint("API Request Failed")
            } else {
                guard let data = data else {
                    self.showErrorAlert("Invalid Email")
                    debugPrint("No data received from the server")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(APIResponse.self, from: data)
                    print(response.message, "response::::")
                    self.showErrorAlert(title: "Alert", response.message) {
                        self.navigationController?.popViewController(animated: true)
                    }
                } catch {
                    self.showErrorAlert("Invalid Email")
                    debugPrint("API Decode Error: \(error)")
                }
            }
        }
    }
}

extension CFForgotViewController: CFLoginDelegate{
    
    override func apiSucess() {
        super.apiSucess()
        
    }
    
}




