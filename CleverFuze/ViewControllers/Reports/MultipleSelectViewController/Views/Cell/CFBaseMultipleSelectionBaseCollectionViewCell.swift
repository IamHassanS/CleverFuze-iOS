//
//  CFBaseMultipleSelectionBaseCollectionViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 17/10/22.
//

import UIKit

class CFBaseMultipleSelectionBaseCollectionViewCell: UICollectionViewCell {
    
    lazy var labelDefault: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var data: CFDropDownDataSource! = nil{
        didSet{
            self.labelDefault.text = self.data?.name
        }
    }
    
    var isSelectedData: Bool! = false{
        didSet{
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setConstraint()
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFBaseMultipleSelectionBaseCollectionViewCell{
    
   @objc func setConstraint(){
        
        self.contentView.addSubview(self.labelDefault)
        
        NSLayoutConstraint.activate([
        
            self.labelDefault.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(5)),
            self.labelDefault.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(40)),
            self.labelDefault.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioWidthBasedOniPhoneX(5)),
            self.labelDefault.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(5)),

        ])
        
    }
    
    @objc func setView(){
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear

    }
    
}
