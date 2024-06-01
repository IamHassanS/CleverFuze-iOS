//
//  CFViewCustomerViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFViewCustomerViewController: CFBaseFieldEntryViewController {

    lazy var controller: CFViewCustomerController! = CFViewCustomerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // set view
        self.setView()
        
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }
        
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .addCustomer{
            self.baseEntryViewController = CFViewCustomerDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()
        CFDropDownController.callDropDownAPI()
    }
    
}


extension CFViewCustomerViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Customer"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFViewCustomerViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFViewCustomerDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
    }
    
}

// MARK: Below function used for navigation
