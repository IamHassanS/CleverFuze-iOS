//
//  UIDate+Extension.swift
//  Humm
//
//  Created by Anilkumar on 25/01/21.
//  Copyright © 2021 AIT. All rights reserved.
//

import UIKit


enum DateReturnType {
  
  case month
  case date
  case time
  case full
  case fullDateWithComma
  case weekDayWithFull //THRUSDAY, SEPT 12
  case fullDateWithHalfMonth
}

extension Date {
  
  func toString(_ format: String.DateFormatType = .isoDate) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.stringFormat
    let strDate = dateFormatter.string(from: self)
    return strDate
    
  }

    
    func addMonths(numberOfMonths: Int) -> Date {
      let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
      return endDate ?? Date()
    }
    

}
