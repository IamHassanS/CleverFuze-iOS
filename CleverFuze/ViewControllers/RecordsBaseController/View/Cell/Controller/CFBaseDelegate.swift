//
//  CFBaseDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 25/08/22.
//

import Foundation

@objc protocol CFBaseDelegate where Self: CFBaseViewController {
    
    @objc optional func apiSucess()
    @objc optional func apiFailure(_ error: String)
    @objc optional func addAndUpdatedSuccessfully(_ error: String)

}

extension CFBaseDelegate{
    
    func enableLoader(){
        DispatchQueue.main.async { [weak self] in
            self?.view.endEditing(true)
            self?.loadingView.setLoadingScreen(view: self?.view ?? .init())
        }
    }
    
    func disableLoader(){
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeLoadingScreen()
        }
    }

}
