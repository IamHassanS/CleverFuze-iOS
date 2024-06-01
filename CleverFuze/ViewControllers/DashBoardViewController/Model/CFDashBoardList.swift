//
//  CFDashBoardList.swift
//  CleverFuze
//
//  Created by Anil Kumar on 25/08/22.
//

import Foundation

enum CFDashBoardList: String, CaseIterable {
    
    case totalRecords = "Total Records"
    case activeRecords = "Active Records"
    case priorWeek = "Prior Week"
    case priorMonth = "Prior Month"
    case priorYear = "Current Year"

}

extension CFDashBoardList{
    
    var endPoint: CFEndPoint{
        switch self {
        case .totalRecords:
            return .totalRecords
        case .activeRecords:
            return .activerecords
        case .priorWeek:
            return .dashboardPriorWeek
        case .priorMonth:
            return .dashboardPriorMonth
        case .priorYear:
            return .dashboardCurrentYear
        }
    }
    
    var startDate: Date?{
        switch self {
        case .totalRecords, .activeRecords:
            return nil
        case .priorWeek:
            return Date().addingTimeInterval(-(7 * 24 * 60 * 60))
        case .priorMonth:
            return Calendar.current.startOfMonth(Date().addMonths(numberOfMonths: -1))
        case .priorYear:
            return Calendar.current.startOfYear(Date().addMonths(numberOfMonths: -1))
        }
    }
    
    var endDate: Date?{
        switch self {
        case .totalRecords, .activeRecords:
            return nil
        case .priorMonth:
            return Calendar.current.endOfMonth(Date().addMonths(numberOfMonths: -1))
        case .priorWeek:
            return Date()
        case .priorYear:
            return Calendar.current.endOfYear(Date().addMonths(numberOfMonths: -1))
        }
    }
    
    var isEditable: Bool{
        switch self {
        case .totalRecords, .activeRecords:
            return true
        case .priorWeek, .priorMonth, .priorYear:
            return false
        }
    }
    
}
