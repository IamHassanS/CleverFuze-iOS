//
//  CFUserDetailViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFUserDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFUserDetailController! = CFUserDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        self.headerView.labelTitle.text = "User"
        self.controller.delegate = self
        
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
  
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        if buttonType == .edit {
            self.baseEntryViewController = CFUserDetailViewController()
            self.navigateToDetailController(with: .edit, data: self.controller.existData)
        } else if buttonType == .Changepassword {
            self.baseEntryViewController = CFUserDetailViewController()
            self.navigateToDetailController(with: .Changepassword, data: self.controller.existData)
        } else {
            debugPrint("empty condition")
        }
    }

  
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFUsersViewController.self, animated: true)

    }

}
