//
//  CFDockViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 01/09/22.
//

import UIKit

class CFDockViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFDockController! = CFDockController()
    
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
        if buttonType == .adddockRelease{
            self.baseEntryViewController = CFDockDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.callAPI()
        self.loadingView.setLoadingScreen(view: self.view)
    }
}


extension CFDockViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Dock Release"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFDockViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFDockDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
       
    }
    
}
