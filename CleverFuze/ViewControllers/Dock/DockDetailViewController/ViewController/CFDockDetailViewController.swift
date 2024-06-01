//
//  CFDockDetailViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 01/09/22.
//

import UIKit

class CFDockDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFDockDetailController! = CFDockDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
       self.enableBackButton()
        self.headerView.labelTitle.text = "Dock Release"        
        self.controller.delegate = self
    }
    
    override func disableDidSelectDocument() {
        if controller.screenType == .view{
            self.didSelectDocument = false
        }else{
            self.didSelectDocument = true
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
        self.baseEntryViewController = CFDockDetailViewController()
        self.navigateToDetailController(with: .edit, data: self.controller.existData)
      }else {
        debugPrint("emty condition")
      }
    }

    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFDockViewController.self, animated: true)
    }
}
