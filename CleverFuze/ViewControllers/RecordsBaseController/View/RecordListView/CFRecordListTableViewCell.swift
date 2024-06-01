//
//  CFRecordListTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFRecordListTableViewCell: UITableViewCell {
    
    lazy var totalRecordView: CFTotalRecordListView! = {
        
        let view = CFTotalRecordListView()
        return view
        
    }()
    
    var indexPath: IndexPath?{
        didSet{
            self.totalRecordView.tag = self.indexPath?.row ?? 0
            self.setValue()
        }
    }

    var data: CFRecordDataSource?{
        didSet{
            self.totalRecordView.data = self.data
        }
    }

    var delegate: CFRecordDataHandlerDelegate?{
        didSet{
            self.totalRecordView.delegate = self.delegate
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFRecordListTableViewCell{
    
    func setView(){
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
    }
    
    func setConstraint(){
        
        self.contentView.addSubview(self.totalRecordView)
        
        NSLayoutConstraint.activate([
        
            self.totalRecordView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.totalRecordView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.totalRecordView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.totalRecordView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

        ])
        
    }
}

extension CFRecordListTableViewCell{
    
    func setHeaderValue(_ title: String?){
        self.contentView.backgroundColor = .primaryColor
        self.totalRecordView.setView(.setFont(.regular, size: .ratioWidthBasedOniPhoneX(16)), isHeader: true)
        self.totalRecordView.titleLabel.text = title
        self.totalRecordView.serialNumberLabel.text = "S.No"
    }
    
    func setValue() {
        self.totalRecordView.setView(.setFont(.regular, size: .ratioWidthBasedOniPhoneX(14)), isHeader: false)
        if ((indexPath?.row ?? 0) % 2) == 0{
            self.contentView.backgroundColor = .secondaryBlueColor
        }else{
            self.contentView.backgroundColor = .secondaryColor
        }
        
    }

}
