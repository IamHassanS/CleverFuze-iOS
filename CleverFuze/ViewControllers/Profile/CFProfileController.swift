//
//  CFProfileController.swift
//  CleverFuze
//
//  Created by venkat subramaian on 05/09/22.
//

import UIKit

class CFProfileController: CFBaseViewController {
    
    
    lazy var profileView: UIView = {
        let profileView = UIView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.cornerRadius = 25
        return profileView
    }()
    
    lazy var profilebtn: UIButton = {
        let profilebtn = UIButton()
        profilebtn.translatesAutoresizingMaskIntoConstraints = false
        profilebtn.setTitle("Profile", for: .normal)
        profilebtn.layer.masksToBounds = true
        return profilebtn
    }()
    
    lazy var logoutbtn: UIButton = {
        let logoutbtn = UIButton()
        logoutbtn.translatesAutoresizingMaskIntoConstraints = false
        logoutbtn.setTitle("Logout", for: .normal)
        logoutbtn.layer.masksToBounds = true
        return logoutbtn
    }()
    
      

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileView)
        profileView.addSubview(profilebtn)
        profileView.addSubview(logoutbtn)
        
        
        NSLayoutConstraint.activate([
        
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(50)),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            profileView.widthAnchor.constraint(equalToConstant: 200),
            
            profilebtn.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            profilebtn.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            profilebtn.topAnchor.constraint(equalTo: profileView.topAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
            
      
            logoutbtn.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            logoutbtn.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            logoutbtn.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
          
        ])
     
    }

}
