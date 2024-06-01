//
//  CFReportGenerateViewController.swift
//  CleverFuze
//
//  Created by venkat subramaian on 07/09/22.
//

import UIKit

class CFViewReportDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFViewReportDetailController! = CFViewReportDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        self.setView()
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
        self.navigationController?.popToViewController(ofClass: CFReportViewController.self, animated: true)
    }
    
}

extension CFViewReportDetailViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Customer Details"
        self.controller.delegate = self
        self.tableView.reloadData()
    }
    
}

