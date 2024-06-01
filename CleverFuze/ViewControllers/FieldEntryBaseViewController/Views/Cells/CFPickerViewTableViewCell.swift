//
//  CFPickerTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFPickerViewTableViewCell: CFEntryFieldTableViewCell {
    
    lazy var pickerView: CFPickerView! = {
        
        let pickerView = CFPickerView()
        pickerView.cfDelegate = self
        return pickerView
        
    }()
    
    override var fieldType: CFCustomFieldType?{
        didSet{
            self.setPickerList()
        }
    }
    
    override var values: Any?{
        didSet{
            self.setPickerList()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFPickerViewTableViewCell{
    
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.setPickerList()
        return super.textFieldShouldBeginEditing(textField)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        self.passTheData(self.pickerView.selectedItem() as Any)
    }
    
}

extension CFPickerViewTableViewCell{
    
    func setPickerList(){
        
        if let datas = self.values as? [CFDropDownDataSource]{
            self.textField.text = datas.compactMap{$0.name}.joined(separator: ", ")
            return
        }
        
        self.pickerView = CFPickerView()
        
        // set data
        self.pickerView?.reloadAllComponents()
        self.pickerView.items = self.fieldType?.dropDown
        self.textField.inputView = pickerView
        if let data = self.existValue(), let firstIndex = self.pickerView?.items?.enumerated().filter({$0.element.id == data.id}).first?.offset{
            pickerView?.selectRow(firstIndex, inComponent: 0, animated: false)
        }else{
            pickerView?.selectRow(0, inComponent: 0, animated: false)
        }
        self.textField.text = self.existValue()?.name ?? (self.values as? String ?? "")
        
    }
    
}

extension CFPickerViewTableViewCell{
    
    func existValue() -> CFDropDownDataSource?{
        return self.values as? CFDropDownDataSource
    }
    
}

extension CFPickerViewTableViewCell: CFPickerViewDelegate{
    
    func pickerDidSelected(_ dataSource: CFDropDownDataSource) {
        self.textField.text = dataSource.name
        self.passTheData(dataSource)
    }
    
}
