//
//  CFViewCustomerViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFViewCustomerDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFViewCustomerDetailController! = CFViewCustomerDetailController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        self.headerView.labelTitle.text = "Customer"
        self.controller.delegate = self
        
        if controller.screenType == .edit{
            controller.currentStorageFetch()
        }
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        if buttonType == .edit{
            self.baseEntryViewController = CFViewCustomerDetailViewController()
            self.navigateToDetailController(with: .edit, data: self.controller.existData)
        }else{
            debugPrint("empty condition")
        }
    }
    
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFViewCustomerViewController.self, animated: true)
    }
}
