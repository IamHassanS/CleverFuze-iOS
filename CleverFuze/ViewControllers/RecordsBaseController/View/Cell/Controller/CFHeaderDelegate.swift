//
//  CFHeaderDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import Foundation

@objc protocol CFHeaderDelegate: AnyObject {
    
    @objc func leftButtonAction()
    @objc func rightButtonAction()

}
