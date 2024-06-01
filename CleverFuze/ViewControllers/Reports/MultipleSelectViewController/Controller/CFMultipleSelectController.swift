//
//  CFMultipleSelectController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 17/10/22.
//

import Foundation

class CFMultipleSelectController: NSObject {
    
    lazy var fieldType: CFCustomFieldType? = nil
    lazy var selectedData: [CFDropDownDataSource]? = []

    weak var delegate: CFMultipleSelectViewDelegate?
    weak var dataPassDelegate: CFSelectionDataSenderDelegate?

}

extension CFMultipleSelectController: CFMultipleSelectionDataSource{
    
    func dataSelectedCount() -> Int {
        return self.selectedData?.count ?? 0
    }
    
    func dataCount() -> Int {
        return self.fieldType?.dropDown.count ?? 0
    }
    
    func dataForIndex(_ index: Int) -> CFDropDownDataSource? {
        return self.fieldType?.dropDown[index]
    }
    
    func isSelected(_ index: Int) -> Bool? {
        guard let dataValue = self.fieldType?.dropDown[index]  else {
            return false
        }
        return !((self.selectedData?.filter{$0.id == dataValue.id && $0.name == dataValue.name} ?? []).isEmpty)
    }
}

extension CFMultipleSelectController: CFMultipleSelectionDelegate{
    
    func closeButtonClicked() {
        self.delegate?.closeButtonClicked()
    }
    
    func doneButtonClicked() {
        self.delegate?.doneButtonClicked()
    }
    
    func didSelectedTheValue(_ index: Int) {
        guard let dataValue = self.fieldType?.dropDown[index]  else {
            return
        }
        if let firstIndex = self.selectedData?.firstIndex(where: {$0.id == dataValue.id && $0.name == dataValue.name}){
            self.selectedData?.remove(at: firstIndex)
        }else{
            self.selectedData?.append(dataValue)
        }
    }
}

extension CFMultipleSelectController{
    
    func passData(){
        self.dataPassDelegate?.didPassTheData(self.fieldType, data: self.selectedData ?? [])
    }
    
}
