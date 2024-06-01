//
//  CFPickerView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit

class CFPickerView: UIPickerView {

    weak var cfDelegate: CFPickerViewDelegate?
    
    lazy var items: [CFDropDownDataSource]! = []{
        didSet{
            self.reloadAllComponents()
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

extension CFPickerView {
    
    func setView(){
        
        self.delegate = self
        self.dataSource = self
        
    }
    
}

    //#MARK: UIPickerView Delegate and DataSource

extension CFPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.items[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cfDelegate?.pickerDidSelected(self.items[row])
    }
    
}

extension CFPickerView{
    
    func selectedItem() -> CFDropDownDataSource?{
        guard self.items.indices.contains(selectedRow(inComponent: 0)) else {
            return nil
        }
        return self.items[selectedRow(inComponent: 0)]
    }
    
}
