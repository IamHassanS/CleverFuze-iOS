//
//  ForgotpasswordViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/09/22.
//

import UIKit

class ForgotpasswordViewController: UIViewController, UITextFieldDelegate {
  
  lazy var views: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()

  lazy var forgotLabel: UILabel! = {
      let forgot = UILabel()
      forgot.translatesAutoresizingMaskIntoConstraints = false
      forgot.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      forgot.text = "You forgot your password?"
     // forgot.backgroundColor = .white
      forgot.textColor = .white
      forgot.textAlignment = .center
      return forgot
  }()

  lazy var forgotpasswordLabel: UILabel! = {
      let forgot = UILabel()
      forgot.translatesAutoresizingMaskIntoConstraints = false
      forgot.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      forgot.text = "Here you can easily retrieve a"
     // forgot.backgroundColor = .white
      forgot.textColor = .white
      forgot.textAlignment = .center
      return forgot
  }()

  lazy var newpasswordLabel: UILabel! = {
      let new = UILabel()
      new.translatesAutoresizingMaskIntoConstraints = false
      new.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      new.text = "new password."
     // forgot.backgroundColor = .white
      new.textColor = .white
      new.textAlignment = .center
      return new
  }()

  lazy var signPasswordButton: UIButton = {
      
      let button = UIButton()
      button.setTitle("Send Password Reset Link", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = .secondaryColor
      button.layer.borderWidth = 1.5
      button.layer.borderColor = UIColor.blue.cgColor
     // button.layer.cornerRadius = 22
      button.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
      button.titleLabel?.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(20))
      button.translatesAutoresizingMaskIntoConstraints  = false
      button.addTarget(self, action: #selector(self.signbuttonAction(_:)), for: .touchUpInside)
      return button
      
  }()
  
  lazy var EmailimgButton: UIButton = {
      
      let button = UIButton()
      
      button.setImage(UIImage(named: "email"), for: .normal)
      button.translatesAutoresizingMaskIntoConstraints  = false
      button.addTarget(self, action: #selector(self.EmailimgAction(_:)), for: .touchUpInside)
      return button
  }()
  

  lazy var forgetEmailTextField: CFLoginTextField! = {
      let textField = CFLoginTextField()
      textField.padding = .init(top: 0, left: .ratioHeightBasedOniPhoneX(26), bottom: 0, right: .ratioHeightBasedOniPhoneX(26))
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.backgroundColor = .clear
      textField.textAlignment = .left
      textField.textColor = UIColor.black
      textField.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
      textField.delegate = self
      textField.keyboardType = .default
      textField.layer.borderWidth = 1.5
      textField.layer.borderColor = UIColor.gray.cgColor
      textField.textColor = .black
      textField.clearButtonMode = UITextField.ViewMode.whileEditing
      textField.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(15))
      textField.attributedPlaceholder = NSAttributedString(
          string: "Email",
          attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)])
      return textField
  }()
  
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
        // Do any additional setup after loading the view.
    }
 
}
extension ForgotpasswordViewController{
    
    
    
    func setConstraints() {
      view.addSubview(views)
      self.views.addSubview(forgotLabel)
      self.views.addSubview(forgotpasswordLabel)
      self.views.addSubview(newpasswordLabel)
      self.views.addSubview(forgetEmailTextField)
      self.views.addSubview(signPasswordButton)
      self.views.addSubview(EmailimgButton)
      NSLayoutConstraint.activate([
      
        self.views.leadingAnchor.constraint(equalTo: views.leadingAnchor),
        self.views.bottomAnchor.constraint(equalTo: views.bottomAnchor),
        self.views.topAnchor.constraint(equalTo: views.topAnchor),
        self.views.trailingAnchor.constraint(equalTo: views.trailingAnchor),
        
        
        self.forgotLabel.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        self.forgotLabel.topAnchor.constraint(equalTo: views.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(200)),
        self.forgotLabel.leadingAnchor.constraint(equalTo: self.views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(40)),
        self.forgotLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
        

        self.forgotpasswordLabel.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        self.forgotpasswordLabel.topAnchor.constraint(equalTo: views.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(250)),
        self.forgotpasswordLabel.leadingAnchor.constraint(equalTo: self.views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(40)),
        self.forgotpasswordLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
        
        
        self.newpasswordLabel.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        self.newpasswordLabel.topAnchor.constraint(equalTo: views.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(300)),
        self.newpasswordLabel.leadingAnchor.constraint(equalTo: self.views.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(30)),
        self.newpasswordLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
        
        
        self.forgetEmailTextField.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        self.forgetEmailTextField.topAnchor.constraint(equalTo: newpasswordLabel.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(100)),
        self.forgetEmailTextField.leadingAnchor.constraint(equalTo: views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(5)),
        self.forgetEmailTextField.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(52)),
        
        
        self.EmailimgButton.trailingAnchor.constraint(equalTo: forgetEmailTextField.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-10)),
        self.EmailimgButton.bottomAnchor.constraint(equalTo: forgetEmailTextField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(-3)),
        self.EmailimgButton.leadingAnchor.constraint(equalTo: forgetEmailTextField.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(285)),
        
        
        self.signPasswordButton.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        self.signPasswordButton.topAnchor.constraint(equalTo: forgetEmailTextField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(50)),
        self.signPasswordButton.leadingAnchor.constraint(equalTo: views.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(5)),
        self.signPasswordButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(52)),
      ])
      
    }
}

extension ForgotpasswordViewController{
  
  @objc private func signbuttonAction(_ sender: UIButton){
      
}
  @objc private func EmailimgAction(_ sender: UIButton){
      self.forgetEmailTextField.isSecureTextEntry = !self.forgetEmailTextField.isSecureTextEntry
  }

}
