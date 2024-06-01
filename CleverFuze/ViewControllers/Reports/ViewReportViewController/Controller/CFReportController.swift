//
//  CFViewReportDetailController.swift
//  CleverFuze
//
//  Created by AnilKumar on 30/08/22.
//

import UIKit

class CFReportController: CFRecordController {

    let viewReportData: CFFieldDataLoder = [0: [.reportManagement, .from, .to, .userStatus, .customerRelease, .releasetype, .warehouse(nil), .customerzone, .customersname, .buttonFooter(.single(.generateReport))], 1: [.reportlist], 2: [.incomeDetails, .incomeList], 3: [.chartDetails, .charts]]
                                             
    lazy var reportFilter: [String:Any]! = [:]{
        didSet{
            self.callAPI()
        }
    }
    
    override var response: CFRecordDataDataSource!{
        didSet{
            self.existLoadedData[.charts] = (self.response as? CFReportResponse)?.chartData
            self.incomeController.response = self.response
        }
    }

    //
    lazy var incomeController: CFReportIncomeListController! = CFReportIncomeListController()

    override init() {
        super.init()
        self.screenType = nil
        self.endPoint = .viewreport
    }
    
    override func loadData() {
        self.loadingData = self.viewReportData
    }
    override func didSetValue(_ data: Any, indexPath: IndexPath, field: CFCustomFieldType) {
        super.didSetValue(data, indexPath: indexPath, field: field)
    }

    override func postBody() -> [String : Any]? {
        var params = [String: Any]()
        
        let datas: [CFCustomFieldType] = [.reportManagement, .from, .to, .userStatus, .customerRelease, .releasetype, .warehouse(nil), .customerzone, .customersname]
        
        for field in datas {
            if let value = self.existLoadedData[field], let key = field.keysForReport {
                switch field {
                case .from, .to:
                    params[key] = (value as? String ?? "")
                case .userStatus:
                    params[key] = (value as? CFDropDownDataSource)?.name?.lowercased() == "Active".lowercased() ? "active" : "in_active"
                case .customerRelease:
                    let arrValue = value as? [CFDropDownDataSource] ?? field.dropDown
                   if arrValue.count == 1 {
                        if arrValue[0].name?.lowercased() == "dock Release".lowercased() {
                            params[key] = ["dock"]
                        }else {
                            params[key] = ["delivery"]
                        }
                    }
                else {
                        params[key] = ["dock", "delivery"]
                    }
                case .warehouse, .customerzone:
                    params[key] = (value as? [CFDropDownDataSource] ?? field.dropDown).compactMap { $0.id }
                case .customersname:
                    params[key] = (value as? [CFDropDownDataSource] ?? field.dropDown).compactMap { $0.customerID }
                case .releasetype:
                    if let releaseType = (value as? [CFDropDownDataSource])?.first(where: { $0.id == 1 }) {
                        params[key] = releaseType.id
                    } else {
                        params[key] = 2
                    }
                default:
                    params[key] = value
                }
            }
        }
        
        return params.isEmpty ? nil : params
    }

    override func callAPI() {
        print(postBody() as Any)
        super.callAPI(type: CFReportResponse.self, postBody: self.postBody())
    }
        
    override func searchFieldDidSearch(_ string: String) {
        if string.isEmpty{
            self.callAPI()
        }else{
            self.searchAPI(string, endPoint: .viewreport, type: CFReportResponse.self)
        }
    }
//        MARK: Below changes for to adding customers name field  in report management :

    override func fieldEditable(_ field: CFCustomFieldType?) -> (editable: Bool, grayOut: Bool) {
        guard let valField = field, [.customerRelease, .warehouse(nil), .customerzone, .customersname, .releasetype].contains(valField) else{
            return super.fieldEditable(field)
        }
        return (false, false)
    }
    
}

extension CFReportController: CFSelectionDataSenderDelegate{
 
    func didPassTheData(_ fieldType: CFCustomFieldType?, data: [CFDropDownDataSource]) {
        guard let fieldType = fieldType else {
            return
        }
        self.existLoadedData[fieldType] = data.isEmpty ? nil : data
        self.delegate?.apiSucess()
    }
    
}

