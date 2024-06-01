//
//  CFViewWareHouseViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFViewWareHouseViewController: CFBaseFieldEntryViewController  {
    
    lazy var controller: CFWareHouseController! = CFWareHouseController()
    
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
        if buttonType == .addWareHouse{
            self.baseEntryViewController = CFViewWarehouseDetailViewController()
            self.navigateToDetailController(with: .add, data: nil)
        }else{
            debugPrint("empty condition")
        }
    }
    
}


extension CFViewWareHouseViewController{
    
    func setView(){
        self.headerView.labelTitle.text = "Warehouse"
        self.controller.delegate = self
        self.tableView.reloadData()
        self.addRefreshController()
    }
    
}

// MARK: Below function used for navigation
extension CFViewWareHouseViewController: CFRecordDelegate{
    
    func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        self.baseEntryViewController = CFViewWarehouseDetailViewController()
        self.navigateToDetailController(with: .view, data: data)
    }
    
}
