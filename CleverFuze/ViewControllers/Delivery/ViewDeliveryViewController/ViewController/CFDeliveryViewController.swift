//
//  CFDeliveryViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 31/08/22.
//

import UIKit

class CFDeliveryViewController: CFBaseFieldEntryViewController {

    lazy var controller: CFDeliveryController! = CFDeliveryController()
    
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
        if buttonType == .adddeliveryRelease{
            self.baseEntryViewController = CFDeliveryDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }

    
}


extension CFDeliveryViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Delivery Release"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFDeliveryViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFDeliveryDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
       
    }
    
}
