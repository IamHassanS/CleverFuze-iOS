//
//  CFDockViewController.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import UIKit

class CFDockViewController: CFBaseFieldEntryViewController {

    lazy var controller: CFDockMainViewController! = CFDockMainViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // set view
        self.setView()
        
        
        
    }
    
    override func baseController() -> CFBaseEntryController! {
        return controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension CFDockViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Customer Release-Dock"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()
        self.headerView.enableBackButton()
    }
    
}
