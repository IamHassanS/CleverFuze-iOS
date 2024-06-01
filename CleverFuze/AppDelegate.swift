//
//  AppDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 23/05/22.
//

import UIKit
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let screenSize = UIScreen.main.bounds
    internal var navigationController:UINavigationController!
    var currentViewController: UIViewController?{
        return (self.window?.rootViewController as? UINavigationController)?.visibleViewController
      }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        Thread.sleep(forTimeInterval: 10.0)
        UIFont.fontNames(forFamilyName: "Source Sans Pro").forEach { dta in
            debugPrint(dta)
        }
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        
        if !UserDefaults.isFirstTime{
            StrongboxController.clearSecureEnclave()
        }
        CFDropDownController.callDropDownAPI()
        CFProfileController.getProfileData()
        self.loadBaseController()
        return true
    }
    func loadBaseController() {
        
        var rootVC : UIViewController!
        
        // start inital page
        if StrongboxController.userData == nil {
            rootVC = CFLoginViewController()
        }else{
            rootVC = (StrongboxController.userData?.userRole == .admin ?  CFHomeDashBaordViewController() : CFViewCustomerViewController()).embeddedSideMenuViewController()
        }
        self.setAsRootViewController([rootVC])
    }
    
    func setAsRootViewController(_ controllers: [UIViewController]){
        self.navigationController =  UINavigationController()
        self.navigationController?.viewControllers = controllers
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
    
}

