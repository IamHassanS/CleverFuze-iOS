//
//  CFRecordViewController.swift
//  CleverFuze
//
//  Created by Anilkumar on 26/08/22.
//

import UIKit

class CFRecordViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFRecordController! = CFRecordController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
    }
    
    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }
    
    override func recallAPI() {
        self.controller.existLoadedData = [:]
        super.recallAPI()
        self.controller.callAPI()
    }
}

extension CFRecordViewController{
    
    func setView(){
        self.headerView.labelTitle.text = self.controller.dashBoardType?.rawValue
        self.tableView.reloadData()
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()
        self.addRefreshController()
        self.enableBackButton()
        self.controller.delegate = self
    }
}

// MARK: Below function used for navigation
extension CFRecordViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
//        let controller = CFViewCustomerDetailViewController()
//        controller.controller.existData = data as? CFRecordDatum
//        self.navigationController?.pushViewController(controller, animated: true)
        
// MARK: Below changes for not able to see customer details :
        
        self.baseEntryViewController = CFViewCustomerDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
        
        
    }
    
}
