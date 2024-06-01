//
//  CFEntryHeaderView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFEntryHeaderTableViewCell: CFEntryBaseTableViewCell {

    lazy var labelTitle: UILabel! = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColor
        label.font = .setFont(.semiBold, size: .ratioHeightBasedOniPhoneX(17))
        label.text = "Customer Name"
        return label
        
    }()
    
    lazy var imageViewArrow: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Vector-10")
        imageView.isHidden = true
        return imageView
        
    }()
    
    override var fieldType: CFCustomFieldType?{
        didSet{
            self.labelTitle.text = self.fieldType?.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFEntryHeaderTableViewCell{
    
    override func setView(){
        super.setView()
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.85)
    }
    
    func setConstraint(){
        
        self.contentView.addSubview(self.labelTitle)
        self.contentView.addSubview(self.imageViewArrow)
        
        NSLayoutConstraint.activate([
        
            self.labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioHeightBasedOniPhoneX(17)),
            self.labelTitle.trailingAnchor.constraint(equalTo: self.imageViewArrow.leadingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),
            self.labelTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioHeightBasedOniPhoneX(15)),
            self.labelTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(15)),

            self.imageViewArrow.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.imageViewArrow.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(15)),
            self.imageViewArrow.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(15)),
            self.imageViewArrow.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),

        ])

    }
    
}
