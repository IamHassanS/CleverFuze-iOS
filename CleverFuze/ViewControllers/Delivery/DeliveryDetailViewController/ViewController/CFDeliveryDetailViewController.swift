//
//  CFDeliveryDetailViewController.swift
//  CleverFuze
//
//  Created by AnilKumar on 31/08/22.
//

import UIKit

class CFDeliveryDetailViewController: CFBaseFieldEntryViewController {

    lazy var controller: CFDeliveryDetailController! = CFDeliveryDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.labelTitle.text = "Delivery Release"
        self.tableView.reloadData()
        self.enableBackButton()
        self.controller.delegate = self
        
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }

    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
      if buttonType == .edit{
        self.baseEntryViewController = CFDeliveryDetailViewController()
        self.navigateToDetailController(with: .edit, data: self.controller.existData)
      }else {
        debugPrint("emty condition")
      }
    }
    
    override func disableDidSelectDocument() {
        if controller.screenType == .view{
            self.didSelectDocument = false
        }else{
            self.didSelectDocument = true
        }
    }
    
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFDeliveryViewController.self, animated: true)
    }
}
