//
//  CFDatePickerTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFDatePickerTableViewCell: CFEntryFieldTableViewCell {
  
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
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFDatePickerTableViewCell{
    
    @objc private func pickerDidChange(_ pickerView: UIDatePicker){
      self.textField.text = pickerView.date.toString(.appFormat)
    }
    
}

extension CFDatePickerTableViewCell{
    
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.setMinMaxDate()
        self.pickerView.date = (values as? String)?.toDate(.isoDate) ?? Date()
        self.textField.inputView = self.pickerView
        return super.textFieldShouldBeginEditing(textField)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        self.passTheData(pickerView.date.toString(.isoDate))
        self.valueChanged()
    }
        
}

extension CFDatePickerTableViewCell{
    
    func setMinMaxDate(){
      
        if [.endDate, .to].contains(self.fieldType), let startDate = self.dataDelegate?.startDate(){
            self.pickerView.minimumDate = startDate
        } else if [.loadDate, .estimatedDateOut].contains(self.fieldType) {
            let distantPastDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
            self.pickerView.minimumDate = distantPastDate
            self.pickerView.maximumDate = nil
        } else {
            self.pickerView.minimumDate = Date().addMonths(numberOfMonths: -(100 * 12))
       
        }
    }
        
    func valueChanged(){
        if self.fieldType == .packDateIn{
            self.dataDelegate?.packedDateChanged()
        }
    }
}


