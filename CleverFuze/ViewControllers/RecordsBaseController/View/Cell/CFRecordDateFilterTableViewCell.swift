//
//  CFRecordDateFilterTableViewCell.swift
//  CleverFuze
//
//  Created by Anilkumar on 26/08/22.
//

import UIKit

class CFRecordDateFilterTableViewCell: CFEntryBaseTableViewCell {
    
    lazy var dateView: CFTotalRecordDateView! = {
        
        let view = CFTotalRecordDateView()
        return view
        
    }()
    
    override var values: Any?{
        didSet{
            self.dateView.values = self.values
        }
    }
    
    override var fieldType: CFCustomFieldType?{
        
        didSet{
            self.setValue()
        }
        
    }
    
    override var dataDelegate: CFFieldEntryDelegate?{
        didSet{
            self.dateView.dataDelegate = self.dataDelegate
        }
    }
    
    override var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.dateView.delegate = self.delegate
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFRecordDateFilterTableViewCell{
    
    func addConstraint() {
        
        self.contentView.addSubview(self.dateView)
        
        NSLayoutConstraint.activate([
            
            self.dateView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(10)),
            self.dateView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(17)),
            self.dateView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioWidthBasedOniPhoneX(17)),
            self.dateView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(10)),
            
        ])
                
    }
    
}

extension CFRecordDateFilterTableViewCell{
    
    func setValue(){
        
        self.dateView.dateLabel.text = self.fieldType?.title
        self.dateView.fieldType = self.fieldType
      switch CFDashBoardList.allCases[0] {
      
//      case .totalRecords:
//        <#code#>
//      case .activeRecords:
//        <#code#>
      case .priorWeek:
        self.dateView.textField.placeholder = self.fieldType == .startDate ? "31/08/2022" : "06/09/2022"
      case .priorMonth:
        self.dateView.textField.placeholder = self.fieldType == .startDate ? "06/08/2022" : "06/8/2022"
      case .priorYear:
         self.dateView.textField.placeholder = self.fieldType == .startDate ? "01/01/2022" : "31/12/2022"
      default :
        self.dateView.textField.placeholder = self.fieldType?.placeHolder
      }
        
    }

}
