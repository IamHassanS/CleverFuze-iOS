//
//  CFReportTableValueList.swift
//  CleverFuze
//
//  Created by Anil Kumar on 03/10/22.
//

import UIKit

class CFReportTableValueList: CFBaseFieldEntryViewController {
  
  lazy var controller: CFViewGenerateReportController! = CFViewGenerateReportController()
  
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
}
extension CFReportTableValueList{
      
      func setView(){
          self.headerView.labelTitle.text = "Reports"
          self.controller.delegate = self
          self.tableView.reloadData()
          self.headerView.enableBackButton()
      }
  
  
}



