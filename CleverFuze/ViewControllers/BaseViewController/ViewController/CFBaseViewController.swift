//
//  CFBaseViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import UIKit

class CFBaseViewController: UIViewController {
    
    lazy var backGroundImageView: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    lazy var headerView: CFHeaderView = {
        
        let view = CFHeaderView()
        view.delegate = self
        return view
        
    }()
    
    lazy var menuView: CFMenuOptionView = {
        
        let profileView = CFMenuOptionView()
        profileView.menuDelegate = self
        return profileView
        
    }()
    
    lazy var loadingView: CFLoadingView! = CFLoadingView()
    
    open func kickBackToListView() { }
    
    override func loadView() {
        super.loadView()
        self.setConstraint()
        self.view.backgroundColor = .white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerView.setProfileForButton()
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadProfileData), name: .profileLoad, object: nil)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
}
extension CFBaseViewController{
    
    func setConstraint(){
        
        self.view.addSubview(self.backGroundImageView)
        self.addHeaderView()
        
        NSLayoutConstraint.activate([
            
            self.backGroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backGroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backGroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backGroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}
extension CFBaseViewController{
    
    func addHeaderView(_ height: CGFloat = .ratioWidthBasedOniPhoneX(95)){
        
        self.view.addSubview(self.headerView)
        
        NSLayoutConstraint.activate([
            
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: height),
            
        ])
    }
}

extension CFBaseViewController{
    
    func enableBackButton(){
        self.headerView.enableBackButton()
    }
    
}

extension CFBaseViewController{
    
    @objc func loadProfileData(){
        self.headerView.setProfileForButton()
    }
    
}

extension CFBaseViewController: CFHeaderDelegate{
    
    func leftButtonAction() {
        self.slideMenuViewController()?.toggleLeft()
    }
    
    func rightButtonAction() {
        self.menuView.superview == nil ? self.addMenuView() : self.menuView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
}
extension CFBaseViewController{
    
    func showErrorAlert(title: String = "Alert",_ error: String?, autoDissmiss: Bool = false, completion: (() -> Void)? = nil){
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: completion)
            }))
            self?.present(alert, animated: true, completion: nil)
            if autoDissmiss {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    alert.dismiss(animated: true, completion: completion)
                }
            }
        }
    }
}
extension CFBaseViewController: CFBaseDelegate{
    
    func apiFailure(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeLoadingScreen()
            self?.showErrorAlert(error)
        }
    }
    
    func apiSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeLoadingScreen()
        }
    }
    
    func addAndUpdatedSuccessfully(_ message: String) {
        self.showErrorAlert(title: "Success",message, autoDissmiss: true) {
            DispatchQueue.main.async {
                self.loadingView.removeLoadingScreen()
                self.kickBackToListView()
            }
        }
    }
    
}
extension CFBaseViewController{
    func addMenuView(){
        self.view.addSubview(self.menuView)
        NSLayoutConstraint.activate([
            self.menuView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.menuView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(20)),
            self.menuView.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(100)),
        ])
    }
}

extension CFBaseViewController: CFMenuOptionDelegate{
    func optionDidSelected(_ menu: CFMenuOption) {
        switch menu {
        case .profile:
            self.navigationController?.pushViewController(CFProfileViewController(), animated: true)
            
        case .logout:
            let alert = UIAlertController(title: "Logout", message: "Are you sure, Do you want to logout?", preferredStyle: .alert)
            
            // Create the actions
            let YesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Yes Pressed")
                StrongboxController.clearSecureEnclave()
                (UIApplication.shared.delegate as? AppDelegate)?.setAsRootViewController([CFLoginViewController()])
            }
            let NoAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("No Pressed")
            }
            
            // Add the actions
            alert.addAction(YesAction)
            alert.addAction(NoAction)
            
            // Present the controller
            self.present(alert, animated: true, completion: nil)
        }
    }
}

public func print(_ object: Any...) {
    #if DEBUG
    for item in object {
    Swift.print(item)
    }
    #endif
}

public func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}


