//
//  CFEntryBaseTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFEntryBaseTableViewCell: UITableViewCell {

    var fieldType: CFCustomFieldType?
    var values: Any?
    var indexPath: IndexPath?
    weak var delegate: CFRecordDataHandlerDelegate?
    weak var dataDelegate: CFFieldEntryDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func validateError() { }
    
}

extension CFEntryBaseTableViewCell{
    
    @objc
    func setView(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        self.selectionStyle = .none
    }
    
    func passTheData(_ values: Any){
        self.values = values
        guard let indexPath = self.indexPath, let fieldType = self.fieldType else {
            return
        }
        self.dataDelegate?.didSetValue(values, indexPath: indexPath, field: fieldType)
        self.validateError()
    }
    
}
