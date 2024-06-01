//
//  CFBaseFieldEntryViewController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFBaseFieldEntryViewController: CFBaseViewController {
    lazy var tableView: UITableView! = {
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        // cell register
        tableView.register(CFEntryFieldTableViewCell.self, forCellReuseIdentifier: String(describing: CFEntryFieldTableViewCell.self))
        tableView.register(CFPickerViewTableViewCell.self, forCellReuseIdentifier: String(describing: CFPickerViewTableViewCell.self))
        tableView.register(CFDatePickerTableViewCell.self, forCellReuseIdentifier: String(describing: CFDatePickerTableViewCell.self))
        tableView.register(CFEntryFooterTableViewCell.self, forCellReuseIdentifier: String(describing: CFEntryFooterTableViewCell.self))
        tableView.register(CFEntryHeaderTableViewCell.self, forCellReuseIdentifier: String(describing: CFEntryHeaderTableViewCell.self))
        tableView.register(CFRecordDateFilterTableViewCell.self, forCellReuseIdentifier: String(describing: CFRecordDateFilterTableViewCell.self))
        tableView.register(CFRecordTableViewCell.self, forCellReuseIdentifier: String(describing: CFRecordTableViewCell.self))
        tableView.register(CFReportRecordTableViewCell.self, forCellReuseIdentifier: String(describing: CFReportRecordTableViewCell.self))
        tableView.register(CFChartTableViewCell.self, forCellReuseIdentifier: String(describing: CFChartTableViewCell.self))
        tableView.register(CFDocumentUploadTableViewCell.self, forCellReuseIdentifier: String(describing: CFDocumentUploadTableViewCell.self))
        
        return tableView
        
    }()

    lazy var refershControl: UIRefreshControl! = {
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.recallAPI), for: .valueChanged)
        control.tintColor = .white
        return control
        
    }()
    var isZoneViewController: Bool = false
    var didSelectDocument: Bool = false
    lazy var baseEntryViewController:CFBaseFieldEntryViewController! = CFBaseFieldEntryViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addConstraint()
        self.didRemoveCallApi()
        self.headerView.labelTitle.text = "View Customer"
        self.disableDidSelectDocument()
    }
    
    @objc func disableDidSelectDocument(){
        self.didSelectDocument = true
    }
    
    func didRemoveCallApi(){
        self.isZoneViewController = true
    }
   
    open func didButtonClicked(_ buttonType: CFButtonVariety?) {
        debugPrint("did  Button  Clicked")
    }
    
    open func baseController(_ type: CFCustomFieldType? = .none) -> CFBaseEntryController! {
        return CFBaseEntryController()
    }

    open func fieldDidSelected(_ type: CFCustomFieldType?) {
        debugPrint("field Did Selected")
    }
}

extension CFBaseFieldEntryViewController{

    func addRefreshController(){
        self.tableView.refreshControl = self.refershControl
    }
    
    @objc func recallAPI(){
        if isZoneViewController{
            self.baseController().callAPI()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refershControl.endRefreshing()
        }
    }
    
}

extension CFBaseFieldEntryViewController{

    func addConstraint(){
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
        ])
    }
    
}

extension CFBaseFieldEntryViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
      return self.baseController().loadingData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseController().loadingData[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CFEntryBaseTableViewCell()
        let fType = self.baseController().loadingData[indexPath.section]?[indexPath.row]
        switch fType{

        case .customerDetails, .propertyDetails, .chartDetails, .documentDetails, .incomeDetails, .reportManagement,
                .addZone, .reports, .profile:
          cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFEntryHeaderTableViewCell.self), for: indexPath) as! CFEntryHeaderTableViewCell
        case .incomeList:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFReportRecordTableViewCell.self), for: indexPath) as! CFReportRecordTableViewCell
        case .startDate, .endDate:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFRecordDateFilterTableViewCell.self), for: indexPath) as! CFRecordDateFilterTableViewCell
          
        case .dashBoardRecordList, .customerList, .customertypeDetails, .warehouseList, .customertypelist, .userList, .companyList, .deliveryList, .dockList, .reportlist:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFRecordTableViewCell.self), for: indexPath) as! CFRecordTableViewCell
            
        case .buttonFooter:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFEntryFooterTableViewCell.self), for: indexPath) as! CFEntryFooterTableViewCell
//        MARK: Below changes for to adding customers name field  in report management :
       
        case .zone, .zoneSelectAddEdit, .state, .customerType, .warehouse, .companyAndOrganization, .userRole, .warehouseLocation, .customerName, .deliveryType, .deliveryZone, .releasetype, .customerzone, .customersname, .customerRelease, .userStatus, .damagaeMissingItems, .documentToUpload:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFPickerViewTableViewCell.self), for: indexPath) as! CFPickerViewTableViewCell
            
        case .loadDate, .packDateIn, .actualdateout, .estimatedDateOut, .deliveryDate, .from, .to, .releaseDate:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFDatePickerTableViewCell.self), for: indexPath) as! CFDatePickerTableViewCell
            
        case .charts:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFChartTableViewCell.self), for: indexPath) as! CFChartTableViewCell
        case .fileInput(_):
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFDocumentUploadTableViewCell.self), for: indexPath) as! CFDocumentUploadTableViewCell
            guard let cell = cell as? CFDocumentUploadTableViewCell else { return UITableViewCell() }
            cell.documentDelegate = self
            cell.didSelectDocument = self.didSelectDocument
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFEntryFieldTableViewCell.self), for: indexPath) as! CFEntryFieldTableViewCell
  
        }
      
        cell.delegate = self.baseController(fType) as? CFRecordDataHandlerDelegate
        cell.dataDelegate = self.baseController(fType)
        cell.fieldType = self.baseController().fieldType(for: indexPath)
        cell.values = self.baseController(fType).getValues(for: indexPath)
        cell.indexPath = indexPath
        cell.layoutIfNeeded()
        return cell
    }
}

extension CFBaseFieldEntryViewController: CFBaseFieldEntryDelegate{
    
    override func apiSucess() {
        super.apiSucess()
        DispatchQueue.main.async { [weak self] in
            self?.refershControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    override func apiFailure(_ error: String) {
        super.apiFailure(error)
        DispatchQueue.main.async { [weak self] in
            self?.refershControl.endRefreshing()
        }
    }
    
    func reloadTheTableView(){
        UIView.performWithoutAnimation { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
                self?.tableView.layoutIfNeeded()
    
            }
        }
    }
    
}

extension CFBaseFieldEntryViewController{
    
    func navigateToDetailController(with type: CFScreenType, data: CFRecordDataSource?){
        self.baseEntryViewController.baseController().existData = data
        self.baseEntryViewController.baseController().screenType = type
        self.navigationController?.pushViewController(self.baseEntryViewController, animated: true)
    }
    
}

extension CFBaseFieldEntryViewController: CFDocumentDelegate, UIDocumentPickerDelegate{
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        debugPrint(urls)
        UserDefaults.saveUserDocument = nil
        if let docData = urls.first?.path{
            UserDefaults.saveUserDocument = docData
        }
        self.baseController()?.documentSelected(urls, fieldType: (controller as? CFDocumentPickerViewController)?.fieldType ?? .fileInput(0))
    }
    
}
