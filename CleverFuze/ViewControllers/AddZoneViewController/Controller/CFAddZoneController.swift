//
//  CFAddZoneController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import UIKit


class CFAddZoneController: CFBaseEntryController {
    var viewZoneData: CFFieldDataLoder = [0: [.addZone, .zoneEntry(0), .buttonFooter(.double(left: .addZone, right: .submit))],
                                          1: [.zoneSelectAddEdit, .buttonFooter(.double(left: .edit, right: .delete))]]
    
    var deleteAction: (() -> ())? = nil

    override init() {
        super.init()
        self.loadingData = self.viewZoneData
    }
  
    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
    
      super.didButtonClicked(buttonType)
    
        switch buttonType{
        case .addZone:
            self.screenType = .add
            self.addZone()
        case .edit:
            self.editZone()
            self.screenType = .edit
            self.editLoadedData[.zoneSelectAddEdit] = self.existLoadedData[.zoneSelectAddEdit]
            self.existLoadedData[.zoneSelectAddEdit] = nil
        case .delete:
            self.screenType = .delete
            if existLoadedData.isEmpty == true {
                self.delegate?.apiFailure(ErrorData.requiredField.rawValue)
            }else{
               deleteAction?()
            }
        case .submit:
            let sType = self.screenType == nil ? .add : self.screenType
            self.screenType = sType
            self.callAPI()
            self.resetData()
        default:
            break
        }
        self.delegate?.apiSucess()
    }

    override func callAPI() {
        
        if self.screenType == .view || self.screenType == nil{
            self.callAPI(type: CFZoneResponse.self)
        }else{
            self.modifyAndAddAPI()
        }

    }
    
    override func callAPI<T:Codable & CFRecordDataDataSource>(type: T.Type, postBody: [String:Any]? = nil){
        super.callAPI(type: type)
        self.resetData()
        CFDropDownController.callDropDownAPI()
        self.delegate?.apiSucess()
    }

    override func postBody() -> [String: Any] {
        var params: [String: Any] = [:]

        if self.screenType == .edit {
            if let dropDownData = self.editLoadedData[.zoneSelectAddEdit] as? CFDropDownReleaseType {
                params = ["zoneCaption": ["caption": [dropDownData.caption].compactMap { $0 },
                                          "id": ["\(dropDownData.id ?? 0)"]]]
                self.editLoadedData[.zoneSelectAddEdit] = nil
            }
        } else {
            params = ["zoneCaption": ["caption": self.existLoadedData.values.compactMap { $0 as? String },
                                      "id": self.existLoadedData.values.compactMap { _ in "0" }]]
            self.existLoadedData[.zoneSelectAddEdit] = nil
        }

        return params
    }

    override func endPoint() -> CFEndPoint? {
        let selectedData = self.existLoadedData[.zoneSelectAddEdit] as? CFDropDownDataSource
        switch self.screenType{
        case .some(.delete):
            return .zoneDelete(id: selectedData?.id ?? 0)
        case .some(.edit):
            return .addZone
        case .some(.add):
            return .addZone
        default:
            return nil
        }
    }

    override func setDataValues(_ customType: CFCustomFieldType? = nil) {
        debugPrint("setDataValues customType")
    }
    
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        super.didSetValue(data, indexPath: indexPath, field: field)
        if field == .zoneEntry(0) && screenType == .edit {
            if let caption = data as? String {
                if var dropDownData = self.editLoadedData[.zoneSelectAddEdit] as? CFDropDownReleaseType {
                    dropDownData.caption = caption
                    self.editLoadedData[.zoneSelectAddEdit] = dropDownData
                }
            }
        }
    }

    
    override func remove(at key: Int, in index: Int) {
        super.remove(at: key, in: index)
        self.viewZoneData[key]?.remove(at: index)
    }

}

extension CFAddZoneController{
    
    func modifyAndAddAPI(){
        if !self.isValidateDatas(){
            self.delegate?.apiFailure(ErrorData.ValidZone.rawValue)
        }else{
            super.startLoadingIndicator()
            guard let endPoint = self.endPoint() else {
                return
            }
            CFCommunicationController.networkRequest(endPoint: endPoint, postBody: self.postBody()) { response in
                self.addEditResponseHandler(response, with: "Zone")
            }
        }
    }
    
}

extension CFAddZoneController {
    
    func resetData(){
        self.viewZoneData = [0: [.addZone, .zoneEntry(0), .buttonFooter(.double(left: .addZone, right: .submit))],
                             1: [.zoneSelectAddEdit, .buttonFooter(.double(left: .edit, right: .delete))]]
        self.loadingData = self.viewZoneData
        self.existLoadedData = [:]
    }
    
    func addZone(){
        
        var value = viewZoneData[0] ?? []
        let count = value.filter({ type in
            if case .zoneEntry(_) = type{
                return true
            }
            return false
        }).count
        value.insert(.zoneEntry(count), at: 1 + (count - 1))
        viewZoneData[0] = value
        self.loadingData = self.viewZoneData
        
    }
    
    func editZone(){
        let value = self.existLoadedData[.zoneSelectAddEdit] as? CFDropDownDataSource
        self.viewZoneData = [0: [.addZone, .zoneEntry(0), .buttonFooter(.double(left: .addZone, right: .submit))],
                             1: [.zoneSelectAddEdit, .buttonFooter(.double(left: .edit, right: .delete))]]
        self.loadingData = self.viewZoneData
        self.existLoadedData[.zoneEntry(0)] = value?.name
        self.existLoadedData[.zoneSelectAddEdit] = value
    }
    
    func deleteZone(){
        guard let id = (self.existLoadedData[.zoneSelectAddEdit]  as? CFDropDownDataSource)?.id else {
            self.delegate?.apiFailure(ErrorData.Zonedelete.rawValue)
            return
        }
        super.startLoadingIndicator()
        CFCommunicationController.networkRequest(endPoint: .zoneDelete(id: id), requestMethod: .get) { response in
            self.delegate?.apiSucess()
            self.existLoadedData = [:]
            self.resetData()
            self.addEditResponseHandler(response, with: "Zone")
        }
        
    }
}
