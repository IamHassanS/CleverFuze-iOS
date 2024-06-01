import Foundation
class CFCustomerTypeDetailViewController: CFBaseFieldEntryViewController {
    
    lazy var controller: CustomerTypeDetailController! = CustomerTypeDetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.enableBackButton()
        self.headerView.labelTitle.text = "Cutomer Type"
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
          self.baseEntryViewController = CFCustomerTypeDetailViewController()
          self.navigateToDetailController(with: .edit, data: self.controller.existData)
      }else{
          debugPrint("empty condition")
      }
  }
  
    override func kickBackToListView() {
        super.kickBackToListView()
        self.navigationController?.popToViewController(ofClass: CFCustomerTypeViewController.self, animated: true)

    }

}
