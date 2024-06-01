//
//  CFEntryFooterStackView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFEntryFooterStackView: UIStackView {
        
    weak var delegate: CFEntryFooterDelegate?
    
    lazy var leftButton: CFButton! = {
        
        let button = CFButton()
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        button.setHeightConstraint(.ratioHeightBasedOniPhoneX(50))
        return button
        
    }()
    
    lazy var rightButton: CFButton! = {
        
        let button = CFButton()
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        button.setHeightConstraint(.ratioHeightBasedOniPhoneX(50))
        return button
        
    }()
    
    var buttonType: CFCustomButtonType?{
        didSet{
            self.setValue()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFEntryFooterStackView{
    
    func setView(){
        
        // self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        //
        self.axis = .horizontal
        self.spacing = .ratioWidthBasedOniPhoneX(20)
        self.alignment = .fill
        self.distribution = .fillEqually
    }
    
    func setStackView(){
        
        self.addArrangedSubview(self.leftButton)
        self.addArrangedSubview(self.rightButton)

    }
    
}

extension CFEntryFooterStackView{
    
    @objc
    func buttonAction(_ button: UIButton){
        let buttonVariety = self.buttomVariety()
        self.delegate?.didButtonClicked(button == self.leftButton ? buttonVariety.left : buttonVariety.right)
    }
}

extension CFEntryFooterStackView{
    
    func buttomVariety() -> (left: CFButtonVariety?, right: CFButtonVariety?){
        
        if case .single(let variety) = self.buttonType  {
            return (nil, variety)
        }
 
        if case .double(let left, let right) = self.buttonType  {
            return (left, right)
        }
        return (nil, nil)
        
    }

}

extension CFEntryFooterStackView{

    func setValue(){
        
        let buttonVariety = self.buttomVariety()
        self.leftButton.isHidden = buttonVariety.left == nil
        self.rightButton.buttonVariety = buttonVariety.right
        self.leftButton.buttonVariety = buttonVariety.left
        
    }

}
