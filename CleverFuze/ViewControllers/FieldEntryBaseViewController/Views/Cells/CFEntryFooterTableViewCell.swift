//
//  CFEntryFooterTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFEntryFooterTableViewCell: CFEntryBaseTableViewCell {
    
    lazy var stackView: CFEntryFooterStackView! = {
        
        let stackView = CFEntryFooterStackView()
        stackView.delegate = self
        return stackView
        
    }()
    
    override var fieldType: CFCustomFieldType?{
        didSet{
            self.setValue()
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

extension CFEntryFooterTableViewCell{
    
    func addConstraint() {
        
        self.contentView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
        
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioHeightBasedOniPhoneX(23)),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioHeightBasedOniPhoneX(17)),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(23)),

        ])
        
    }
    
}

extension CFEntryFooterTableViewCell{
    
    func setValue(){
        guard case .buttonFooter(let buttonType) = fieldType else {
            return
        }
        self.stackView.buttonType = buttonType
    }
    
}

extension CFEntryFooterTableViewCell: CFEntryFooterDelegate{
    
    func didButtonClicked(_ buttonType: CFButtonVariety?) {
        self.dataDelegate?.didButtonClicked(buttonType)
    }
    
}
