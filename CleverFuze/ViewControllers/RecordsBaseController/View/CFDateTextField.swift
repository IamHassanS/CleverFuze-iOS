//
//  CFDateTextField.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFDateTextField: CFTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        super.setView()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primaryColor.cgColor
        self.backgroundColor = .white
        self.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(16))
    }
    
}
