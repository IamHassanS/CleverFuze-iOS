//
//  CFViewWarehouseDetailViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFViewWarehouseDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFViewWarehouseDetailController! = CFViewWarehouseDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.labelTitle.text = "Warehouse"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.enableBackButton()
        
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        if buttonType == .edit{
            self.baseEntryViewController = CFViewWarehouseDetailViewController()
            self.navigateToDetailController(with: .edit, data: self.controller.existData)
        }else{
            debugPrint("empty condition")
        }
    }
    
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFViewWareHouseViewController.self, animated: true)
    }
}
