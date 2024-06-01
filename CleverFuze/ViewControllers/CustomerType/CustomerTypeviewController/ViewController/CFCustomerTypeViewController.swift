//
//  CFCustomerTypeViewController.swift
//  CleverFuze
//
//  Created by AIT MAC on 8/31/23.
//

import Foundation
class CFCustomerTypeViewController: CFBaseFieldEntryViewController  {
    
    lazy var controller: CustomerTypeController! = CustomerTypeController()
    
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
        if buttonType == .addCustomertype{
            self.baseEntryViewController = CFCustomerTypeDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }
    
}


extension CFCustomerTypeViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Customer Type"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFCustomerTypeViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFCustomerTypeDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
    }
    
}
