//
//  CFViewReportDetailViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 30/08/22.
//

import UIKit

class CFViewReportDetailViewController: CFBaseFieldEntryViewController {

    lazy var controller: CFViewReportDetailController! = CFViewReportDetailController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        //self.setView()

    }
    
    override func baseController() -> CFBaseEntryController! {
        return self.controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit{
           // self.callAPI()
        }else{
            debugPrint("Nothing to action")
        }
    
    }
    
}

extension CFViewReportDetailViewController{
        
        func setView(){
            self.headerView.labelTitle.text = "Reports"
            self.controller.delegate = self
            self.tableView.reloadData()
           // self.loadingView.setLoadingScreen(view: self.view)
            self.controller.callAPI()
            self.headerView.enableBackButton()
        }

}

