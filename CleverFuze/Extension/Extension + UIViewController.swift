//
//  Extension + UIViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

extension UIViewController{
    
    func embeddedSideMenuViewController(_ indexPath: IndexPath = IndexPath(row: 0, section: 0)) -> ExSlideMenuController{
        let leftViewController = CFSideMenuViewController()
        leftViewController.leftMenuController.selectedIndexPath = indexPath
        let slideMenuController = ExSlideMenuController(mainViewController: self, leftMenuViewController: leftViewController)
        slideMenuController.navigationController?.navigationBar.isHidden = true
        slideMenuController.delegate = self as? SlideMenuControllerDelegate
        return slideMenuController
    }
    
}
