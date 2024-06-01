//
//  CFForgotPasswordViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/09/22.
//

import UIKit

class CFForgotPasswordViewController: CFBaseViewController, UITextFieldDelegate {
  
  lazy var View: UIView = {
    let Views = UIView()
    Views.translatesAutoresizingMaskIntoConstraints = false
    Views.backgroundColor = .clear
    return Views
  }()


  lazy var forgotLabel: UILabel! = {
      let forgot = UILabel()
      forgot.translatesAutoresizingMaskIntoConstraints = false
      forgot.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      forgot.text = "You forgot your password?"
      forgot.textColor = .white
      forgot.textAlignment = .center
      return forgot
  }()

  lazy var forgotpasswordLabel: UILabel! = {
      let forgot = UILabel()
      forgot.translatesAutoresizingMaskIntoConstraints = false
      forgot.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      forgot.text = "Here you can easily retrieve a"
      forgot.textColor = .white
      forgot.textAlignment = .center
      return forgot
  }()

  lazy var newpasswordLabel: UILabel! = {
      let new = UILabel()
      new.translatesAutoresizingMaskIntoConstraints = false
      new.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(24))
      new.text = "new password."
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

  lazy var forgetEmailTextfield : UITextField = {
      let textfield = UITextField()
      textfield.translatesAutoresizingMaskIntoConstraints = false
      textfield.borderStyle = .bezel
      textfield.delegate = self
      textfield.keyboardType = .default
      textfield.layer.borderColor = UIColor.gray.cgColor
      textfield.textColor = UIColor.black
      textfield.backgroundColor = .white
      textfield.textAlignment = .left
      textfield.layer.borderWidth = 1.5
      textfield.layer.cornerRadius = .ratioHeightBasedOniPhoneX(26)
      textfield.layer.masksToBounds = true
      textfield.clearButtonMode = UITextField.ViewMode.whileEditing
      textfield.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(15))
      return textfield
  }()
  lazy var leftButton: UIButton! = {
      
      let leftButton = UIButton()
      leftButton.translatesAutoresizingMaskIntoConstraints = false
      leftButton.backgroundColor = .clear
      leftButton.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
      //leftButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
      return leftButton
      
  }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
       self.headerView.isHidden = true
       self.setConstraints()
       self.backGroundImageView.image = UIImage(named: "signInBackgroundImage")
        // Do any additional setup after loading the view.
    }
 
}
extension CFForgotPasswordViewController{
    
      func setConstraints() {
      view.addSubview(View)
      self.View.addSubview(forgotLabel)
      self.View.addSubview(forgotpasswordLabel)
      self.View.addSubview(newpasswordLabel)
      self.View.addSubview(forgetEmailTextfield)
      self.View.addSubview(signPasswordButton)
      self.View.addSubview(EmailimgButton)
      self.View.addSubview(leftButton)
      self.View.addSubview(backGroundImageView)
      NSLayoutConstraint.activate([
        
        self.backGroundImageView.leadingAnchor.constraint(equalTo: self.View.leadingAnchor),
        self.backGroundImageView.trailingAnchor.constraint(equalTo: self.View.trailingAnchor),
        self.backGroundImageView.topAnchor.constraint(equalTo: self.View.topAnchor),
        self.backGroundImageView.bottomAnchor.constraint(equalTo: self.View.bottomAnchor),
        
        
        self.forgotLabel.centerXAnchor.constraint(equalTo: View.centerXAnchor),
        self.forgotLabel.topAnchor.constraint(equalTo: View.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(200)),
        self.forgotLabel.leadingAnchor.constraint(equalTo: self.View.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(40)),
        self.forgotLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),


        self.forgotpasswordLabel.centerXAnchor.constraint(equalTo: View.centerXAnchor),
        self.forgotpasswordLabel.topAnchor.constraint(equalTo: View.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(250)),
        self.forgotpasswordLabel.leadingAnchor.constraint(equalTo: self.View.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(40)),
        self.forgotpasswordLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),

//
        self.newpasswordLabel.centerXAnchor.constraint(equalTo: View.centerXAnchor),
        self.newpasswordLabel.topAnchor.constraint(equalTo: View.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(300)),
        self.newpasswordLabel.leadingAnchor.constraint(equalTo: self.View.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(30)),
        self.newpasswordLabel.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
//
//
        self.forgetEmailTextfield.centerXAnchor.constraint(equalTo: View.centerXAnchor),
        self.forgetEmailTextfield.topAnchor.constraint(equalTo: newpasswordLabel.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(100)),
        self.forgetEmailTextfield.leadingAnchor.constraint(equalTo: View.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(5)),
        self.forgetEmailTextfield.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(52)),

//
        self.EmailimgButton.trailingAnchor.constraint(equalTo: forgetEmailTextfield.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-10)),
        self.EmailimgButton.bottomAnchor.constraint(equalTo: forgetEmailTextfield.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(-3)),
        self.EmailimgButton.leadingAnchor.constraint(equalTo: forgetEmailTextfield.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(285)),
//
//
        self.signPasswordButton.centerXAnchor.constraint(equalTo: View.centerXAnchor),
        self.signPasswordButton.topAnchor.constraint(equalTo: forgetEmailTextfield.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(50)),
        self.signPasswordButton.leadingAnchor.constraint(equalTo: View.leadingAnchor,constant: .ratioWidthBasedOniPhoneX(5)),
        self.signPasswordButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(52)),

        self.leftButton.leadingAnchor.constraint(equalTo: View.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
        self.leftButton.bottomAnchor.constraint(equalTo: View.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(22)),
        self.leftButton.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(25)),
        self.leftButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(25)),
     ])

    }
}
//extension CFForgotPasswordViewController{
//
//    func enableBackButton(){
//      self.leftButton.setImage(#imageLiteral(resourceName:"backIcon-White"), for: .normal)
//
//    }
//
//}

extension CFForgotPasswordViewController{

  @objc private func signbuttonAction(_ sender: UIButton){

}
  @objc private func EmailimgAction(_ sender: UIButton){
      self.forgetEmailTextfield.isSecureTextEntry = !self.forgetEmailTextfield.isSecureTextEntry
      }

}

