//
//  CFReportIncomeListController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 04/10/22.
//

import Foundation

class CFReportIncomeListController: CFRecordController{
            
    override var response: CFRecordDataDataSource!{
        didSet{
            let response = (self.response as? CFReportResponse)
            let dataSource = (response?.countTableData ?? [])
            self.allData = dataSource
            self.chunckData = dataSource.chunked(by: dataSource.count)
            self.delegate?.apiSucess()
        }
    }
        
    override func data(for index: Int) -> CFRecordDataSource? {
        self.chunckData[currentViewPageIndex]?[index]
    }
    
    override func dataDidSelected(for index: Int, data: CFRecordDataSource?) {
        (self.delegate as? CFRecordDelegate)?.dataDidSelected(for: index, data: data)
    }
   
}

//#MARK: Record handler
extension CFReportIncomeListController{
    
    override func totalPage() -> Int {
        return chunckData.count
    }
    
    override func dataCountForCurrentPage() -> Int {
        return self.chunckData[currentViewPageIndex]?.count ?? 0
    }
    
    override func currentPageIndex() -> Int {
        return self.currentViewPageIndex
    }
    
    override func didSetCurrentPageIndex(_ page: Int) {
        self.currentViewPageIndex = page
    }
      
    override func reloadTheData() {
    self.delegate?.reloadTheTableView()
  }
  
}

