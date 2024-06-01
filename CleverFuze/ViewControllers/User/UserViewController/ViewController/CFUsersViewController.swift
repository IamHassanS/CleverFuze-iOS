//
//  CFUsersViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFUsersViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFUsersController! = CFUsersController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set view
        self.setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()

    }
   
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .addUser{
            self.baseEntryViewController = CFUserDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }
}


extension CFUsersViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Users"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFUsersViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
      self.baseEntryViewController = CFUserDetailViewController()
      self.navigateToDetailController(with: .view, data: data)
        
    }
    
}
