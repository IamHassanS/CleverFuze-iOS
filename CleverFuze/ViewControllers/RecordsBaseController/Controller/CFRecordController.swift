//
//  CFRecordController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFRecordController: CFBaseEntryController {
  
    // for record List
    open var endPoint: CFEndPoint! = .totalRecords
    open var dashBoardType: CFDashBoardList?{
        didSet{
            self.endPoint = self.dashBoardType?.endPoint
            self.existLoadedData[.startDate] = self.dashBoardType?.startDate?.toString(.isoDate)
            self.existLoadedData[.endDate] = self.dashBoardType?.endDate?.toString(.isoDate)
        }
    }

    open var allData: [CFRecordDataSource] = []
    open var response: CFRecordDataDataSource!
    open var chunckData: [Int: [CFRecordDataSource]] = [:]
    open var currentViewPageIndex: Int! = 0

    //
    var recordData: CFFieldDataLoder! = [:]{
        didSet{
            self.loadingData = recordData
        }
    }
        
    override init() {
        super.init()
        self.loadingData = recordData
          }
        
    override func callAPI() {
        self.callAPI(type: CFRecordResponse.self)
        self.endPoint = self.dashBoardType?.endPoint
    }
    
    override func callAPI<T:Codable & CFRecordDataDataSource>(type: T.Type, postBody: [String:Any]? = nil){
        super.callAPI(type: type)
        CFCommunicationController.networkRequest(endPoint: self.endPoint, postBody: postBody) { [weak self] (data, error, statusCode) in
            if let error = error{
                self?.delegate?.apiFailure(error)
            }else{
                guard let data = data, let reponse = try? JSONDecoder().decode(T.self, from: data) else{
                    self?.delegate?.apiFailure(CFErrorMessage.defaultError)
                    return
                }
                self?.loadData()
                self?.response = reponse
                self?.allData = reponse.dataSouce ?? []
                self?.chunckData = (reponse.dataSouce ?? []).chunked(by: CFConstant.recordCountPerPage)
                self?.delegate?.apiSucess()
            }
        }
    }
    
    //
    open func searchFieldDidSearch(_ string: String) {
        let filterData = self.allData.filter{$0.name?.lowercased().contains(string.lowercased()) ?? false}
        self.chunckData =  (string.isEmpty ? self.allData : filterData).chunked(by: CFConstant.recordCountPerPage)
        self.delegate?.apiSucess()
    }
    
    open func data(for index: Int) -> CFRecordDataSource? {
        self.chunckData[currentViewPageIndex]?[index]
    }
    
    open func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        (self.delegate as? CFRecordDelegate)?.dataDidSelected(for: index, data: data)
    }

    override func didButtonClicked(_ buttonType: CFButtonVariety?) {
        super.didButtonClicked(buttonType)
        if buttonType == .submit{
            self.filterAPI()
        }
    }
    
    override func setValues() {
        debugPrint("Override the super class function")
        self.delegate?.apiSucess()
    }
    
    override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        guard let dashBoardType = self.dashBoardType else{
            return super.fieldEditable(field)
        }
        return (dashBoardType.isEditable, self.screenType == .edit)
    }
    
    override func fieldDidSelected(_ field: CFCustomFieldType?) {
        super.fieldDidSelected(field)
        
    }
}

extension CFRecordController{

    func searchAPI<T:Codable & CFRecordDataDataSource>(_ string: String, endPoint: CFEndPoint, type: T.Type){
        self.delegate?.enableLoader()
        CFCommunicationController.networkRequest(endPoint: endPoint, postBody: ["keyword": string]) { [weak self] (data, error, statusCode) in
            if let error = error{
                self?.delegate?.apiFailure(error)
            }else{
                guard let data = data, let reponse = try? JSONDecoder().decode(T.self, from: data) else{
                    self?.delegate?.apiFailure(CFErrorMessage.defaultError)
                    return
                }
                self?.loadData()
                self?.chunckData = (reponse.dataSouce ?? []).chunked(by: 10)
                self?.delegate?.apiSucess()
          
            }
        }
        
    }
    
}

extension CFRecordController{
    
    @objc func loadData(){
        self.loadingData = [0: [.activeRecords, .totalRecords].contains(self.dashBoardType ?? .totalRecords) ? [.startDate, .endDate, .buttonFooter(.single(.submit))] : [.startDate, .endDate],
                            1: [.dashBoardRecordList]]
    }
    
}

extension CFRecordController{
    
    func filterAPI(){
        
        self.endPoint = .filter
        guard let delegate = self.delegate else {
            return
        }
        delegate.loadingView.setLoadingScreen(view: delegate.view)
        guard let startDateStr = self.existLoadedData[.startDate] as? String else{
            delegate.apiFailure("Please enter the valid Start Date")
            return
        }
        
        guard let endDateStr = self.existLoadedData[.endDate] as? String else{
            delegate.apiFailure("Please enter the valid End Date")
           return
        }
        
        let postBody = ["startdate": startDateStr, "enddate": endDateStr]
        self.callAPI(type: CFRecordResponse.self, postBody: postBody)
        
    }

}

//#MARK: Record handler
extension CFRecordController: CFRecordDataHandlerDelegate{
    
    @objc func totalPage() -> Int {
        return chunckData.count
    }
    
    @objc func dataCountForCurrentPage() -> Int {
        return self.chunckData[currentViewPageIndex]?.count ?? 0
    }

    @objc func currentPageIndex() -> Int {
        return self.currentViewPageIndex
    }
    
    @objc func didSetCurrentPageIndex(_ page: Int) {
        self.currentViewPageIndex = page
    }
    
    @objc func reloadTheData() {
        self.delegate?.reloadTheTableView()
    }
    
}

