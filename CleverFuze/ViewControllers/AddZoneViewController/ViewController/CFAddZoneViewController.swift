//
//  CFAddZoneViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFAddZoneViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFAddZoneController! = CFAddZoneController()
    
    let cfAddZoneController = CFAddZoneController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.labelTitle.text = "Zone"
        self.controller.delegate = self
        self.tableView.reloadData()
        deleteZoneButtonTapped()
        self.addRefreshController()
        self.loadingView.setLoadingScreen(view: self.view)
        cfAddZoneController.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingView.setLoadingScreen(view: self.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingView.removeLoadingScreen()
        }
    }
    
    override func didRemoveCallApi() {
        self.isZoneViewController = false
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }
    func deleteZoneButtonTapped() {
        controller.deleteAction = {
            let alertController = UIAlertController(
                title: "Delete Zone",
                message: "Are you sure you want to delete this zone?",
                preferredStyle: .alert
            )
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.controller.deleteZone()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
