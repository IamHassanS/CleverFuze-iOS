//
//  CFBaseEntryFieldTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFEntryFieldTableViewCell: CFEntryBaseTableViewCell {

    lazy var labelTitle: UILabel! = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .setFont(.regular, size: .ratioHeightBasedOniPhoneX(16))
        label.text = "Customer Name"
        return label
        
    }()
    
    lazy var textField: CFTextField! = {
        
        let textField = CFTextField()
        textField.delegate = self
        return textField
        
    }()
    
    lazy var labelError: UILabel! = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .setFont(.semiBold, size: .ratioHeightBasedOniPhoneX(12))
        label.text = ""
        return label
        
    }()

    lazy var seperatorView: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
        
    }()
    
    lazy var removeButton: UIButton! = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .setFont(.regular, size: .ratioHeightBasedOniPhoneX(16))
        button.setTitle("Remove", for: .normal)
        button.addTarget(self, action: #selector(self.removeButtonAction), for: .touchUpInside)
        return button
        
    }()
    
    override var fieldType: CFCustomFieldType?{
        didSet{
            self.textField.fieldType = self.fieldType
            self.labelTitle.text = self.fieldType?.title
            self.removeButton.isHidden = self.fieldType?.isNeedRemoveButton ?? true
            guard let grayOut = self.dataDelegate?.fieldEditable(self.fieldType).grayOut,
                  let editable = self.dataDelegate?.fieldEditable(self.fieldType).editable  else {
                return
            }
            self.textField.backgroundColor = grayOut && !editable ?  UIColor.black.withAlphaComponent(0.35) : .clear
        }
    }
    
    override var values: Any?{
        didSet{
            self.textField.text = self.values as? String ?? ""
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func validateError() {
        super.validateError()

        if fieldType == .zip {
            if let zipValue = values as? String {
                let isZipValid = zipValue.count == 5
                self.labelError.text = isZipValid ? "" : ErrorData.ZipError.rawValue
                self.seperatorView.backgroundColor = isZipValid ? .white : .red
            } else {
                self.labelError.text = ErrorData.ZipError.rawValue
                self.seperatorView.backgroundColor = .red
            }
        }else if fieldType == .NewPassword{
            let isValueEmpty = (values == nil || (values as? String) == "")
            self.labelError.text = isValueEmpty ? ErrorData.newpasswordandconfirm.rawValue : ""
            self.seperatorView.backgroundColor = isValueEmpty ? .red : .white
        }else if fieldType == .confirmPasswordz{
            let isValueEmpty = (values == nil || (values as? String) == "")
            self.labelError.text = isValueEmpty ? ErrorData.newpasswordandconfirm.rawValue : ""
            self.seperatorView.backgroundColor = isValueEmpty ? .red : .white
        }
        else if fieldType != .serviceNumber && fieldType != .scacNumber && fieldType != .warehouseLocation && fieldType != .addressLine2 && fieldType != .overflow && fieldType != .actualIncome && fieldType != .initialStorage && fieldType != .quarterlyStorage && fieldType != .totalincomv && fieldType != .totalIncome && fieldType != .totalHandling && fieldType != .currentStorage {
            self.labelError.text = ((self.values == nil || (self.values as? String) == "") && ((fieldType?.needValidation) ?? true)) ? ErrorData.fieldError.rawValue : ""
            self.seperatorView.backgroundColor = (self.values == nil || (self.values as? String) == "") ? .red : .white
        }
    }

    
}

extension CFEntryFieldTableViewCell{

    func setConstraint(){
        
        self.contentView.addSubview(self.labelTitle)
        self.contentView.addSubview(self.removeButton)
        self.contentView.addSubview(self.textField)
        self.contentView.addSubview(self.seperatorView)
        self.contentView.addSubview(self.labelError)

        NSLayoutConstraint.activate([
        
            self.labelTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
            self.labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioHeightBasedOniPhoneX(17)),
            self.labelTitle.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),

            self.removeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),
            self.removeButton.centerYAnchor.constraint(equalTo: self.labelTitle.centerYAnchor),

            self.textField.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
            self.textField.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(25)),
            self.textField.leadingAnchor.constraint(equalTo: self.labelTitle.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioHeightBasedOniPhoneX(17)),

            self.seperatorView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
            self.seperatorView.heightAnchor.constraint(equalToConstant: 1),
            self.seperatorView.leadingAnchor.constraint(equalTo: self.labelTitle.leadingAnchor),
            self.seperatorView.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor),
            
            self.labelError.topAnchor.constraint(equalTo: self.seperatorView.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(5)),
            self.labelError.leadingAnchor.constraint(equalTo: self.labelTitle.leadingAnchor),
            self.labelError.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor),
            self.labelError.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(5)),

        ])

    }
    
}

extension CFEntryFieldTableViewCell: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.dataDelegate?.fieldDidSelected(self.fieldType)
        return self.dataDelegate?.fieldEditable(self.fieldType).editable ?? false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.passTheData(textField.text as Any)
    }
}

extension CFEntryFieldTableViewCell{
    
    @objc
    func removeButtonAction(){
        self.dataDelegate?.didSelectedTheRemove(self.fieldType)
    }
    
}
