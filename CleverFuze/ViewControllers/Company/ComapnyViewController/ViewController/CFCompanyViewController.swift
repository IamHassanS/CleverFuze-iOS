//
//  CFCompanyViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFCompanyViewController: CFBaseFieldEntryViewController  {
    
    lazy var controller: CFComapnyController! = CFComapnyController()
    
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
      if buttonType == .addCompany{
          self.baseEntryViewController = CFCompanyDetailViewController()
          self.navigateToDetailController(with: .add, data: nil)
      }else{
          debugPrint("empty condition")
      }
  }
}


extension CFCompanyViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Company"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFCompanyViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
      self.baseEntryViewController = CFCompanyDetailViewController()
      self.navigateToDetailController(with: .view, data: data)

    }
    
}
