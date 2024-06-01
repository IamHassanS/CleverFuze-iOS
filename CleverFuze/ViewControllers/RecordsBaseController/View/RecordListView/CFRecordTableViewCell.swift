//
//  CFRecordTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFRecordTableViewCell: CFEntryBaseTableViewCell {

    lazy var recordView: CFRecordView! = {
        
        let view = CFRecordView()
        return view
        
    }()
    
    override var fieldType: CFCustomFieldType?{
        didSet{
            self.setValue()
        }
    }

    weak override var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.recordView.delegate = self.delegate
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

extension CFRecordTableViewCell{
    
    func addConstraint(){
        
        self.contentView.addSubview(self.recordView)
        
        NSLayoutConstraint.activate([
        
            self.recordView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(17)),
            self.recordView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(17)),
            self.recordView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioWidthBasedOniPhoneX(17)),
            self.recordView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(17)),

        ])
        
    }
    
}

extension CFRecordTableViewCell{
    
    func setValue(){
        
        guard let value = self.fieldType else {
            return
        }
        self.recordView.value = value
    }
    
}
