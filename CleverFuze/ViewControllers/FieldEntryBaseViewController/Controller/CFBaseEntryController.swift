//
//  CFBaseEntryController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//


//
//  CFBaseEntryController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

typealias CFFieldDataLoder = [Int:[CFCustomFieldType]]

class CFBaseEntryController: NSObject {

    // common for all screen
    weak var delegate: CFBaseFieldEntryDelegate?
    open var loadingData: CFFieldDataLoder! = [:]{
        didSet{
            self.setValues()
        }
    }
    
    // data for customer values
    var existLoadedData: [CFCustomFieldType: Any]! = [:]
    
    var editLoadedData: [CFCustomFieldType: Any]! = [:]
    
    var existData: CFRecordDataSource?{
        didSet{
            self.setValues()
        }
    }

    var screenType: CFScreenType?{
        didSet{
            self.setDataValues()
        }
    }
    
    open func didButtonClicked(_ buttonType: CFButtonVariety?) {
        self.delegate?.didButtonClicked(buttonType)
        if buttonType == .delete{
            self.screenType = .delete
        }
    }
    
    open func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType){
        self.existLoadedData?[field] = data
        self.delegate?.reloadTheTableView()
    }

    open func callAPI<T:Codable & CFRecordDataDataSource>(type: T.Type, postBody: [String:Any]? = nil) { }
    open func callAPI() { }
    open func endPoint() -> CFEndPoint? { return nil}
    open func postBody() -> [String: Any]? { return nil }
    open func remove(at key: Int, in index: Int) { }

    open func setDataValues(_ customType: CFCustomFieldType? = nil){
        guard let screenType = self.screenType, let userRole = StrongboxController.userData?.userRole else { return  }
        switch (screenType, userRole){
        case (.view, .admin):
            self.addTheFieldsInLast(.buttonFooter(.double(left: .edit, right: .delete)))
        case (.edit, .admin), (.add, .admin), (.add, .manager), (.edit, .manager):
            self.addTheFieldsInLast(customType ?? .buttonFooter(.single(.submit)))
        case (.view, .manager):
            self.addTheFieldsInLast(.buttonFooter(.single(.edit)))
        default:
            break
        }
    }
    
    open func setValues(){
        let values = self.loadingData.compactMap{$0.value}.reduce([], +)
        guard let existdata = self.existData else {
            return
        }
        self.existLoadedData = existdata.getExistData(values)
    }
    open func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        var editable = false
        var grayOut = false
        switch field {

        case .currentStorage where self.screenType == .add ||  StrongboxController.userData?.userRole == .manager:
                      editable = false
        case .currentStorage where self.screenType == .edit || StrongboxController.userData?.userRole == .manager:
                       editable = false
        default:
            editable = self.screenType?.isEditable ?? true
        }
        return (editable, self.screenType == .edit)
    }
    open func didSelectedTheRemove(_ fieldType: CFCustomFieldType?) {
        self.removeField(fieldType)
    }
    
    open func fieldDidSelected(_ field: CFCustomFieldType?) {
        self.delegate?.fieldDidSelected(field)
    }
    
}


extension CFBaseEntryController{
    
    func detailsModifyAPI(_ type: String) {
        
//        if !self.isValidateDatas(), self.screenType != .delete{
//            self.delegate?.apiFailure(ErrorData.requiredField.rawValue)
//        }else{
            guard let endpoint = self.endPoint()
        else {
                return
            }
            self.startLoadingIndicator()
            CFCommunicationController.networkRequest(endPoint: endpoint, requestMethod: [CFScreenType.delete, CFScreenType.activated, CFScreenType.deActivated].contains(self.screenType ?? .view) ? .get : .post, postBody: self.screenType == .delete ? nil : self.postBody()) { response in
                self.addEditResponseHandler(response, with: type)
            }
//        }
        
    }
    
}

extension CFBaseEntryController{
        
    func startLoadingIndicator(){
        guard let view = self.delegate?.view else {
            return
        }
        self.delegate?.loadingView.setLoadingScreen(view: view)
    }
    
}

extension CFBaseEntryController{
    
    func fieldType(for indexPath: IndexPath) -> CFCustomFieldType?{
        return self.loadingData[indexPath.section]?[indexPath.row]
    }
    
}

extension CFBaseEntryController{

    func getValues(for indexPath: IndexPath) -> Any?{
        guard let fieldType = self.fieldType(for: indexPath) else{
            return nil
        }
        return self.existLoadedData?[fieldType] as Any
    }
    
}

extension CFBaseEntryController: CFFieldEntryDelegate{
    
    func startDate() -> Date? {
        let string = (self.existLoadedData[.startDate] ?? self.existLoadedData[.from]) as? String
        return string?.toDate(.isoDate)
    }
    
    func packedDate() -> Date? {
        let string = self.existLoadedData[.packDateIn] as? String
        return string?.toDate(.isoDate)
    }

    func packedDateChanged() {
        self.existLoadedData[.estimatedDateOut] = nil
        self.existLoadedData[.loadDate] = nil
        self.delegate?.apiSucess()
    }
}

extension CFBaseEntryController{

    func addTheFieldsInLast(_ field: CFCustomFieldType){
        let keyCount = self.loadingData.count - 1
        var oldValues = self.loadingData[keyCount]
        oldValues?.append(field)
        self.loadingData[keyCount] = oldValues

    }

}

extension CFBaseEntryController{
    
    func isValidateDatas() -> Bool{
        
        let values = self.loadingData.compactMap{$0.value}.reduce([], +)
        for value in values where value.needValidation{
            guard let data = self.existLoadedData?[value] else {
                return false
            }
            if let string = data as? String, string.isEmpty{
                return false
            }
        }
        return true
        
    }
        
}

extension CFBaseEntryController{
    
    func addEditResponseHandler(_ response: CFResponse, with message: String){
        
        guard let response = response.data?.convertToCodable(CFFieldChangesResponse.self) else {
            self.delegate?.apiFailure(CFErrorMessage.requiredField)
            return
        }
        if let bool = response.status, bool{
            self.delegate?.addAndUpdatedSuccessfully(message + " \(self.screenType?.rawValue ?? "") Successfully")
            CFDropDownController.callDropDownAPI()
        }else if let error = response.error?.first{
            self.delegate?.apiFailure(error)
        }else{
            self.delegate?.apiFailure(CFErrorMessage.requiredField)
        }
        
    }
    
}

extension CFBaseEntryController{
    
    func addMoreStaff(){
        
        var value = loadingData[0] ?? []
        let count = value.filter{ $0.title == CFCustomFieldType.staffName(0).title}.count
        let index = value.lastIndex{ $0.uniqueValue == CFCustomFieldType.staffName(count - 1).uniqueValue} ?? 0
        value.insert(.staffName(count), at: 1 + index)
        loadingData[0] = value
        self.delegate?.apiSucess()
        
    }
    
    func documentSelected(_ urls: [URL], fieldType: CFCustomFieldType){
        self.existLoadedData[fieldType] = urls.first
        self.delegate?.apiSucess()
    }

}

// #MARK: For dock and delivery release

extension CFBaseEntryController{
    
    func validateDamagaeMissingItems(_ value: CFDropDownValue?){
        
        if value?.name?.lowercased() == "no"{
            self.removeAddFileForMissingItems()
        }else{
            self.addAddFileForMissingItems()
        }
        self.delegate?.apiSucess()
        
    }
    
    func addAddFileForMissingItems(){
        
        var value = self.loadingData[0] ?? []
        guard !value.contains(where: {$0 == .fileInput(0)}) else {
            return
        }
        guard let index = value.firstIndex(where: {$0 == .damagaeMissingItems}) else {
            return
        }
        value.insert(.fileInput(0), at: index + 1)
        self.loadingData[0] = value
        
    }
    
    func removeAddFileForMissingItems(){
        
        var value = self.loadingData[0] ?? []
        guard let index = value.firstIndex(where: {$0 == .fileInput(0)}) else {
            return
        }
        value.remove(at: index)
        self.loadingData[0] = value
        
    }
    
}

extension CFBaseEntryController{
    
    func removeField(_ fieldType: CFCustomFieldType?){
        
        guard let fieldType = fieldType else{
            return
        }
        
        for (key, value) in self.loadingData ?? [:] where value.contains(fieldType){
            if let index = value.firstIndex(of: fieldType){
                self.loadingData[key]?.remove(at: index)
                self.remove(at: key, in: index)
                self.existLoadedData?[fieldType] = nil
                self.delegate?.apiSucess()
                return
            }
        }
        
    }
    
}
