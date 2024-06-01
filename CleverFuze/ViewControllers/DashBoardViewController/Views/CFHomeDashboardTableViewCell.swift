//
//  CFHomeDashboaardTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 02/08/22.
//

import UIKit

class CFHomeDashboardTableViewCell: UITableViewCell {

    lazy var containerView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = .ratioHeightBasedOniPhoneX(20)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var recordsCountLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.bold, size: .ratioWidthBasedOniPhoneX(36))
        label.textColor = .primaryColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var recordsTitleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(18))
        label.textColor = .primaryColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var imageIcon: UIImageView! = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "bar-chart-2")
        return imageView
        
    }()
    
    lazy var buttonMore: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(#imageLiteral(resourceName: "arrowRight"), for: .normal)
        button.titleLabel?.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(14))
        button.backgroundColor = .primaryColor
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(self.didMoreSelect), for: .touchUpInside)
        return button
        
    }()
    
    weak var delegate: CFDashboardMoreActionDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.selectionStyle = .none
        
        self.addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFHomeDashboardTableViewCell{
    
    func addConstraint() {
        
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.recordsTitleLabel)
        self.containerView.addSubview(self.recordsCountLabel)
        self.containerView.addSubview(self.imageIcon)
        self.containerView.addSubview(self.buttonMore)
        
        NSLayoutConstraint.activate([
        
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(31)),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(31)),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioWidthBasedOniPhoneX(7)),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(7)),

            self.recordsCountLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: .ratioHeightBasedOniPhoneX(12)),
            self.recordsCountLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(27)),

            self.recordsTitleLabel.topAnchor.constraint(equalTo: self.recordsCountLabel.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(2)),
            self.recordsTitleLabel.leadingAnchor.constraint(equalTo: self.recordsCountLabel.leadingAnchor),

            self.imageIcon.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: .ratioHeightBasedOniPhoneX(16)),
            self.imageIcon.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(16)),
            self.imageIcon.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(56)),
            self.imageIcon.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(56)),
            
            self.buttonMore.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(33)),
            self.buttonMore.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.buttonMore.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.buttonMore.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),

        ])

    }
}

extension CFHomeDashboardTableViewCell{

    @objc
    func didMoreSelect(){
        self.delegate?.didMoreSelected(self.tag)
       
        
    }
    
}
