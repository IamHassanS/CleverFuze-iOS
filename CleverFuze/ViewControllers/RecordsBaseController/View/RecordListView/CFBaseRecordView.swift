//
//  CFBaseRecordView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 04/10/22.
//

import UIKit

class CFBaseRecordView: UIView {

    lazy var noRecordFoundLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.bold, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        label.text = "No records found"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var tableView: UITableView! = {
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(CFRecordListTableViewCell.self, forCellReuseIdentifier: String(describing: CFRecordListTableViewCell.self))
        tableView.isScrollEnabled = false
        return tableView
        
    }()
    
    // Type of field
    var value: CFCustomFieldType?
    
    // height constraint for adjustment
    lazy var tableViewHeightConstraint: NSLayoutConstraint! = NSLayoutConstraint()
    lazy var noRecordFoundLabelBottomConstraint: NSLayoutConstraint! = NSLayoutConstraint()

    weak var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.tableView.reloadData()
        }
    }

    open func currentPage() -> Int{
        return 0
    }
    
    open func hideTheAllView() { }
    open func moveToPreviousPage() { }
    @objc func setConstraint() { }
    @objc func setConstraintForEmptyLabel() { }
    @objc func setValueView() { }

}

extension CFBaseRecordView: UITableViewDelegate, UITableViewDataSource{
        
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = self.delegate?.dataCountForCurrentPage() ?? 0
        self.setViewBasedOnValue(rowsCount)
        return  rowsCount + (rowsCount == 0 ? 0 : 1)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CFRecordListTableViewCell.self), for: indexPath) as! CFRecordListTableViewCell
        if indexPath.row == 0{
            cell.setHeaderValue(self.value?.title)
        }else{
            cell.indexPath = indexPath
            cell.totalRecordView.serialNumberLabel.text = "\(indexPath.row + (self.currentPage() * CFConstant.recordCountPerPage)) "
            cell.data = self.delegate?.data(for: indexPath.row - 1)
        }
        cell.delegate = self.delegate
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? .ratioHeightBasedOniPhoneX(50) : .ratioHeightBasedOniPhoneX(45)
    }
   
}

extension CFBaseRecordView{
    
    func setViewBasedOnValue(_ count: Int){
        
        if count == 0{
            if let currentPage = self.delegate?.currentPageIndex(), currentPage >= 1{
                self.moveToPreviousPage()
            }else{
                self.tableViewHeightConstraint.constant = 0
                self.setConstraintForEmptyLabel()
            }
        }else{
            self.setValueView()
            self.tableViewHeightConstraint.constant = 50 + (CGFloat(count) * .ratioHeightBasedOniPhoneX(45)) + .ratioHeightBasedOniPhoneX(65)
        }
        
    }
        
}
