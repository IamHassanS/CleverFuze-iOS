//
//  CFRecordDataHandlerDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import Foundation

protocol CFRecordDataHandlerDelegate: AnyObject{
    
    func currentPageIndex() -> Int
    func totalPage() -> Int
    func didSetCurrentPageIndex(_ page: Int)
    func dataCountForCurrentPage() -> Int
    func data(for index: Int) -> CFRecordDataSource?
    func dataDidSelected(for index: Int, data: CFRecordDataSource?)
    func searchFieldDidSearch(_ string: String)
    func reloadTheData()
  
}
