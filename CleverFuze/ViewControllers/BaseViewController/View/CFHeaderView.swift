//
//  CFHeaderView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import UIKit

class CFHeaderView: UIView {

    lazy var leftButton: UIButton! = {
        
        let leftButton = UIButton()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.backgroundColor = .clear
        leftButton.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        leftButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        return leftButton
        
    }()
    
    lazy var labelTitle: UILabel! = {
        
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = .setFont(.semiBold, size: 20)
        labelTitle.backgroundColor = .clear
        labelTitle.textColor = .white
        return labelTitle
        
    }()
    
    lazy var rightButton: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.kf.setBackgroundImage(with: URL(string: StrongboxController.profileData?.profile ?? ""), for: .normal, placeholder: #imageLiteral(resourceName: "UserAvatar"))
        button.viewCornerRadius = .ratioWidthBasedOniPhoneX(15)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.maskBounds = true
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        return button
        
    }()
    
    weak var delegate: CFHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .primaryColor
        self.setConstraint()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = .ratioWidthBasedOniPhoneX(30)
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
}

extension CFHeaderView{
    
    func setConstraint(){
        
        
        self.addSubview(self.leftButton)
        self.addSubview(self.labelTitle)
        self.addSubview(self.rightButton)


        NSLayoutConstraint.activate([
            
            self.leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
            self.leftButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(22)),
            self.leftButton.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(25)),
            self.leftButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(25)),
            
            self.labelTitle.centerYAnchor.constraint(equalTo: self.leftButton.centerYAnchor),
            self.labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(33)),
            self.rightButton.bottomAnchor.constraint(equalTo: self.leftButton.bottomAnchor),
            self.rightButton.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),
            self.rightButton.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(30)),

        ])
        
    }
}

extension CFHeaderView{

    func enableBackButton(){
        self.leftButton.setImage(#imageLiteral(resourceName:"backIcon-White"), for: .normal)
    }
    
    func enableCloseButton(){
        self.leftButton.setImage(#imageLiteral(resourceName:"backIcon-White"), for: .normal)
    }
    
    func setProfileForButton(){
        DispatchQueue.main.async { [weak self] in
            self?.rightButton.kf.setBackgroundImage(with: URL(string: StrongboxController.profileData?.profile ?? ""), for: .normal, placeholder: #imageLiteral(resourceName: "UserAvatar"))
        }
    }

}

extension CFHeaderView{
    
    @objc private func buttonAction(_ sender: UIButton){
        if sender == self.leftButton{
            self.delegate?.leftButtonAction()
        }else{
            self.delegate?.rightButtonAction()
        }
    }
    
}
      


