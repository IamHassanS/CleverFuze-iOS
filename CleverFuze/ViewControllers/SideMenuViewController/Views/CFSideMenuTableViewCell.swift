//
//  CFSideMenuTableViewCell.swift
//  CleverFuze
//
//  Created by Ajith  on 24/05/22.
//

import UIKit

class CFSideMenuTableViewCell: UITableViewCell {

    lazy var imageIcon: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    lazy var titleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(18))
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    lazy var selectView: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.viewCornerRadius = .ratioWidthBasedOniPhoneX(12)
        view.maskBounds = true
        return view
        
    }()
    
    var sideMenu: CFSideMenu?  {
        didSet{
            self.titleLabel.text = self.sideMenu?.title
            self.imageIcon.image = self.sideMenu?.image
        }
    }
        
    deinit {
        self.sideMenu = nil
        self.titleLabel = nil
        self.imageIcon = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add view
        self.contentView.addSubview(self.imageIcon)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.selectView)
        
        // self
        self.backgroundView?.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.setConstraintForOption()
        self.setView()
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFSideMenuTableViewCell{
    
    func setConstraintForOption(){
        // add constraint
        self.imageIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.imageIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: CGFloat.ratioHeightBasedOniPhoneX(32)).isActive = true
        self.imageIcon.heightAnchor.constraint(equalToConstant: CGFloat.ratioHeightBasedOniPhoneX(24)).isActive = true
        self.imageIcon.widthAnchor.constraint(equalToConstant: CGFloat.ratioHeightBasedOniPhoneX(24)).isActive = true
        
        self.titleLabel.centerYAnchor.constraint(equalTo: self.imageIcon.centerYAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.imageIcon.trailingAnchor, constant: CGFloat.ratioWidthBasedOniPhoneX(22)).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -CGFloat.ratioWidthBasedOniPhoneX(10)).isActive = true

        self.selectView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.selectView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(15)).isActive = true
        self.selectView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(15)).isActive = true
        self.selectView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    }
    
    func setView(){
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        //         Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .lightText
        self.selectedBackgroundView = myCustomSelectionColorView
    }
            
}
