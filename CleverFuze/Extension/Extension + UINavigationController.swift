//
//  Extension + UINavigationController.swift
//  The_Travel_App
//
//  Created by Anil Kumar on 01/08/22.
//  Copyright © 2022 AIT. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    @discardableResult
    func popToViewController(ofClass: AnyClass, animated: Bool = true) -> UIViewController? {
        if let vc = viewControllers.last(where: { ($0 as? ExSlideMenuController)?.mainViewController?.isKind(of: ofClass) ?? false }) {
            self.popToViewController(vc, animated: animated)
            return vc
        }
        return nil
    }
    
}
