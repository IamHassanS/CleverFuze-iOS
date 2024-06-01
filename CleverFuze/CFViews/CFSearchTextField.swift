//
//  CFSearchTextField.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit
import IQKeyboardManagerSwift

class CFSearchTextField: UISearchTextField {

    weak var searchDelegate: CFRecordDataHandlerDelegate?
    
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
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "Search"
        self.backgroundColor = .white
        self.returnKeyType = .search
        self.directionalLayoutMargins = .init(top: 0, leading: .ratioWidthBasedOniPhoneX(23), bottom: 0, trailing: 0)
        self.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(self.textFieldDidEndEditing(_:)))
    }
}

extension CFSearchTextField: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchDelegate?.searchFieldDidSearch(self.text ?? "")
    }

}
