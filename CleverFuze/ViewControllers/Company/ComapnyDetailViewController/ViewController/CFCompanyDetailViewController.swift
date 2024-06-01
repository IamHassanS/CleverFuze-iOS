//
//  CFCompanyDetailViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFCompanyDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CFCompanyDetailController! = CFCompanyDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        self.headerView.labelTitle.text = "Company"
        self.controller.delegate = self
        
    }
    
    override func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return self.controller
    }
    
    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hasValidationError() -> Bool {
        // Assume no errors by default
        var hasError = false
        
        // Iterate through all sections
        for section in 0..<tableView.numberOfSections {
            // Iterate through all rows in the current section
            for row in 0..<tableView.numberOfRows(inSection: section) {
                // Check if the cell is of type CFEntryFieldTableViewCell
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? CFEntryFieldTableViewCell {
                    // Validate error for the cell
                    cell.validateError()
                    // Check for error condition
                    if cell.labelError.text != "" {
                        // Set hasError to true and break from the inner loop
                        hasError = true
                        break
                    }
                }
            }
            // If an error was found, reload the table view and exit the outer loop
            if hasError {
                tableView.reloadData()
                break
            }
        }
        
        // Return whether an error was found
        return hasError
    }
    
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        debugPrint("Button clicked: \(String(describing: buttonType))")
        if hasValidationError() {
            print("Validation Error")
        } else {
            debugPrint("No validation errors")
            if buttonType == .submit || buttonType == .delete {
                // No validation errors, proceed with API call
                debugPrint("Making API call")
                self.controller.detailsModifyAPI("Company")
            } else if buttonType == .edit {
                debugPrint("Navigating to Detail Controller")
                self.baseEntryViewController = CFCompanyDetailViewController()
                self.navigateToDetailController(with: .edit, data: self.controller.existData)
            } else {
                debugPrint("Empty condition")
            }
        }
    }
    
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFCompanyViewController.self, animated: true)
    }
    
}
