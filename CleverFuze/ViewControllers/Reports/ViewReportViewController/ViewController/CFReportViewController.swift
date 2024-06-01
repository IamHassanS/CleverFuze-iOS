//
//  CFViewReportDetailViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 30/08/22.
//

import UIKit

class CFReportViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFReportController! = CFReportController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setView()
        }
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return type == .incomeList ? self.controller.incomeController : self.controller
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .generateReport{
            self.loadingView.setLoadingScreen(view: self.view)
            self.controller.reportFilter = self.controller.postBody()
        }else{
            debugPrint("empty condition")
        }
    }
    
    override func fieldDidSelected(_ type: CFCustomFieldType?) {
        super.fieldDidSelected(type)
        guard let valType = type else {
            return
        }
//        MARK: Below changes for to adding customers name field  in report management :

        if [.customerRelease, .warehouse(nil), .customerzone, .customersname, .releasetype].contains(valType){
            let controller = CFMultipleSelectViewController()
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            controller.controller.fieldType = type
            controller.controller.dataPassDelegate = self.controller
            controller.controller.selectedData = self.controller.existLoadedData[valType] as? [CFDropDownDataSource] ?? []
            self.present(controller, animated: true)
        }
    }
    
    override func recallAPI() {
        self.controller.existLoadedData = [:]
        super.recallAPI()
    }
}

extension CFReportViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Reports Management"
        self.controller.delegate = self
        self.loadingView.setLoadingScreen(view: self.view)
        self.controller.callAPI()
        self.addRefreshController()
    }
    
}


// MARK: Below function used for navigation
extension CFReportViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFViewReportDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
    }
    
}
