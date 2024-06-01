//
//  CFDeliveryViewController.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import UIKit

class CFDeliveryViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFDeliveryMainViewController! = CFDeliveryMainViewController()
    

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
extension CFDeliveryViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Customer Release-Delivery"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()
        self.headerView.enableBackButton()
    }
    
}
