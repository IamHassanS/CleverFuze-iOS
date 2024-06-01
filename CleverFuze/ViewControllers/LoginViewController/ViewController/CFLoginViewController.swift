//
//  CFLoginViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import Foundation
import UIKit

class CFLoginViewController: CFBaseViewController, UITextFieldDelegate{
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "launchScreenLogo")
        return imageView
    }()
    
    lazy var Views: UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        View.backgroundColor = .clear
        return View
    }()

  
    lazy var signinLabel: UILabel! = {
        let signin = UILabel()
        signin.translatesAutoresizingMaskIntoConstraints = false
        signin.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
        signin.text = "Sign in"
        signin.backgroundColor = .clear
        signin.textColor = .black
        signin.textAlignment = .center
        return signin
    }()
  
  
    lazy var emailTextField: CFLoginTextField! = {
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
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)])
        return textField
    }()
    
    lazy var passwordField: CFLoginTextField! = {
        let textField = CFLoginTextField()
        textField.padding = .init(top: 0, left: .ratioHeightBasedOniPhoneX(26), bottom: 0, right: .ratioHeightBasedOniPhoneX(26))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black.withAlphaComponent(0.3)
        textField.textAlignment = .left
        textField.textColor = UIColor.white
        textField.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
        textField.delegate = self
        textField.keyboardType = .default
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(15))
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)])
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(12))
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.addTarget(self, action: #selector(self.forgotPasswordAction(_:)), for: .touchUpInside)
        return button
        
    }()
  
  
    
    lazy var SigninButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(12))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondaryColor
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.addTarget(self, action: #selector(self.signindAction(_:)), for: .touchUpInside)
        return button
        
    }()
    lazy var PasswordIyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye") , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.addTarget(self, action: #selector(self.passwordIyeconAction(_:)), for: .touchUpInside)
        button.isSelected = true
        return button
    }()
    
    
    lazy var modelController: CFLoginController? = CFLoginController()
    
    override func loadView() {
        super.loadView()
        self.backGroundImageView.image = UIImage(named: "signInBackgroundImage")
        self.headerView.isHidden = true
        self.modelController?.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
    }
    
    
}



extension CFLoginViewController{
    
    
    
    func setConstraints() {
      
        view.addSubview(Views)
        self.Views.addSubview(emailTextField)
        self.Views.addSubview(signinLabel)
        self.Views.addSubview(logoImageView)
        self.Views.addSubview(passwordField)
        self.Views.addSubview(PasswordIyeButton)
        self.Views.addSubview(forgotPasswordButton)
        self.Views.addSubview(SigninButton)
        NSLayoutConstraint.activate([
          
            self.Views.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor),
            self.Views.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor),
            self.Views.topAnchor.constraint(equalTo: backGroundImageView.topAnchor),
            self.Views.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor),
            
            self.logoImageView.leadingAnchor.constraint(equalTo: Views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(93)),
            self.logoImageView.topAnchor.constraint(equalTo: Views.topAnchor, constant: .ratioHeightBasedOniPhoneX(100)),
            self.logoImageView.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(182)),
            self.logoImageView.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(122)),
            
            self.signinLabel.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.signinLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(55)),
            self.signinLabel.leadingAnchor.constraint(equalTo: self.Views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(70)),
            self.signinLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
            
            self.emailTextField.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.emailTextField.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(27)),
            self.emailTextField.leadingAnchor.constraint(equalTo: Views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(13)),
            self.emailTextField.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(52)),
            
            self.passwordField.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.passwordField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(27)),
            self.passwordField.leadingAnchor.constraint(equalTo: Views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(13)),
            self.passwordField.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(52)),
            
            self.PasswordIyeButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-10)),
            self.PasswordIyeButton.bottomAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(-12)),
            self.PasswordIyeButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(285)),
            
            
            self.forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            self.forgotPasswordButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(22)),
            self.forgotPasswordButton.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(91)),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(15)),
         
            
            self.SigninButton.centerXAnchor.constraint(equalTo: Views.centerXAnchor),
            self.SigninButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(20)),
            self.SigninButton.leadingAnchor.constraint(equalTo: Views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(13)),
            self.SigninButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(52)),
        
            
        ])
        
        
    }
    
    
}

extension CFLoginViewController {
    
    @objc private func forgotPasswordAction(_ sender: UIButton){
      self.navigationController?.pushViewController(CFForgotViewController(), animated: true)
    }
    
    @objc private func signindAction(_ sender: UIButton){
        self.loadingView.setLoadingScreen(view: self.view)
        self.modelController?.login(credentials: .init(email: self.emailTextField.text , password: self.passwordField.text))
    }
    
    @objc private func passwordIyeconAction(_ sender: UIButton){
        self.passwordField.isSecureTextEntry = !self.passwordField.isSecureTextEntry
        self.PasswordIyeButton.setImage(self.passwordField.isSecureTextEntry ? UIImage(named: "eye") : UIImage(named: "eyehide"), for: .normal)
    }
    
}

extension CFLoginViewController: CFLoginDelegate{
    
    override func apiSucess() {
        super.apiSucess()
        DispatchQueue.main.async {
            CFDropDownController.callDropDownAPI()
            CFProfileController.getProfileData()
            (UIApplication.shared.delegate as? AppDelegate)?.setAsRootViewController([(StrongboxController.userData?.userRole == .admin ?  CFHomeDashBaordViewController() : CFViewCustomerViewController()).embeddedSideMenuViewController()])
        }
        
    }
    
    override func apiFailure(_ error: String) {
        super.apiFailure(error)
        
    }
    
}






