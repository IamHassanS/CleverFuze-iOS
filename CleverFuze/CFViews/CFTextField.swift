//
//  CFTextField.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFTextField: UITextField {
    
    lazy var leftButtonView: UIView! = {
        
        let view = UIView(frame: .init(x: 0, y: 0, width: .ratioWidthBasedOniPhoneX(48), height: .ratioWidthBasedOniPhoneX(48)))
        view.addSubview(self.buttonLeft)
        return view
        
    }()
    
    lazy var rightButtonView: UIView! = {
        
        let view = UIView(frame: .init(x: 0, y: 0, width: .ratioWidthBasedOniPhoneX(48), height: .ratioWidthBasedOniPhoneX(48)))
        view.addSubview(self.buttonRight)
        return view
        
    }()
    
    lazy var buttonRight: UIButton! = {
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: .ratioWidthBasedOniPhoneX(48), height: .ratioWidthBasedOniPhoneX(48)))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.buttonRightAction), for: .touchUpInside)
        return button
        
    }()
    
    lazy var buttonLeft: UIButton! = {
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: .ratioWidthBasedOniPhoneX(48), height: .ratioWidthBasedOniPhoneX(48)))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.buttonLeftAction), for: .touchUpInside)
        return button
        
    }()
        
    var fieldType: CFCustomFieldType?{
        didSet{
            self.placeholder = self.fieldType?.placeHolder
            self.keyboardType = self.fieldType?.keyboardType ?? .default
            self.setValue()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFTextField{
    
    @objc
    func setView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.borderStyle = .none
        self.textColor = .black
        self.font = .setFont( .regular, size: .ratioWidthBasedOniPhoneX(14))
    }
    
    func setRightView(_ image: UIImage){
        self.rightView = self.rightButtonView
        self.rightViewMode = .always
        self.buttonRight.setImage(image, for: [.normal])
    }
    
    func setLeftView(_ image: UIImage){
        self.leftView = self.leftButtonView
        self.leftViewMode = .always
        self.buttonLeft.setImage(image, for: [.normal])
    }
    
    func removeRightView(){
        self.rightView = nil
        self.rightViewMode = .never
        self.buttonRight.setImage(nil, for: [.normal])
    }
    
    func removeLeftView(){
        self.leftView = nil
        self.leftViewMode = .never
        self.buttonLeft.setImage(nil, for: [.normal])
    }
    
}

extension CFTextField{
    
    @objc
    func buttonRightAction(){
        
    }
    
    @objc
    func buttonLeftAction(){
        
    }
    
}

extension CFTextField{
    
    func setValue(){
        
        if let leftImage = self.fieldType?.modeImage.left{
            self.setLeftView(leftImage)
        }else{
            self.removeLeftView()
        }
        
        if let rightImage = self.fieldType?.modeImage.right{
            self.setRightView(rightImage)
        }else{
            self.removeRightView()
        }

    }
    
}
