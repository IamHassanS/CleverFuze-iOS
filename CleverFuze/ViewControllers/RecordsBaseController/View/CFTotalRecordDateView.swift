//
//  CFTotalRecordView.swift
//  CleverFuze
//
//  Created by Anilkumar on 26/08/22.
//

import UIKit

class CFTotalRecordDateView: UIView {
  
    lazy var dateLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.semiBold, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var textField: CFDateTextField! = {
        
        let textField = CFDateTextField()
        textField.setHeightConstraint(.ratioHeightBasedOniPhoneX(36))
        textField.delegate = self
        return textField
        
    }()
    
    lazy var pickerView: UIDatePicker! = {
        
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
          picker.preferredDatePickerStyle = .wheels
        }
        picker.maximumDate = Date()
        picker.minimumDate = Date().addMonths(numberOfMonths: -(100 * 12))
        picker.addTarget(self, action: #selector(self.pickerDidChange(_:)), for: .valueChanged)
        return picker
        
      }()
    
    var fieldType: CFCustomFieldType?{
        didSet{
            self.textField.fieldType = self.fieldType
        }
    }

    var values: Any?{
        didSet{
            self.pickerView.date = (values as? String)?.toDate(.isoDate) ?? Date()
            self.textField.text = values as? String ?? ""
        }
    }
    
    weak var delegate: CFRecordDataHandlerDelegate?
    weak var dataDelegate: CFFieldEntryDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        // set view and constraint
        self.addConstraint()
        self.setView()
        
    }
    
    deinit {
        self.dateLabel = nil
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CFTotalRecordDateView{
    
    func setView(){
        
        //
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
    }
    
    func addConstraint(){
        // add View
        self.addSubview(self.dateLabel)
        self.addSubview(self.textField)

        // add constraint
        NSLayoutConstraint.activate([
            
            self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(27)),
            
            self.textField.topAnchor.constraint(equalTo: self.topAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textField.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(186) ),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }
    
}

extension CFTotalRecordDateView{
    
    @objc private func pickerDidChange(_ pickerView: UIDatePicker){
        self.textField.text = pickerView.date.toString(.appFormat)
        guard let fieldType = self.fieldType else {
            return
        }
        self.dataDelegate?.didSetValue(pickerView.date.toString(.isoDate), indexPath: IndexPath(), field: fieldType)
    }
    
}


extension CFTotalRecordDateView: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if [.endDate, .to].contains(self.fieldType), let startDate = self.dataDelegate?.startDate(){
            self.pickerView.minimumDate = startDate
        }else{
            self.pickerView.minimumDate = Date().addMonths(numberOfMonths: -1200)
        }
        self.textField.inputView = self.pickerView
        return self.dataDelegate?.fieldEditable(self.fieldType).editable ?? true
    }
    
}
