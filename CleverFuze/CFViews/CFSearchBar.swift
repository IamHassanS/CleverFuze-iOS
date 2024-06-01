//
//  CFSearchTextField.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFSearchTextField: UISearchTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFSearchTextField{
    
    func setView(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "Search"
        self.backgroundColor = .white
        self.directionalLayoutMargins = .init(top: 0, leading: .ratioWidthBasedOniPhoneX(23), bottom: 0, trailing: 0)
        
    }
    
}
