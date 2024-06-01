//
//  Extension + String.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import Foundation

extension String {
    
    public enum DateFormatType {
        
        /// The ISO8601 formatted year "yyyy" i.e. 1997
        case isoYear
        
        /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
        case isoYearMonth
        
        /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
        case isoDate
        
        /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
        case isoDateTime
        
        /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
        case isoDateTimeSec
        
        /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
        case isoDateTimeMilliSec
        
        /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
        case rss
        
        /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
        case altRSS
        
        /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
        case httpHeader
        
        /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
        case standard
        
        /// A custom date format string
        case custom(String)
        
        case appFormat
        
        var stringFormat:String {
            switch self {
                //handle iso Time
            case .appFormat: return "dd-MM-yyyy"
            case .isoYear: return "yyyy"
            case .isoYearMonth: return "yyyy-MM"
            case .isoDate: return "yyyy-MM-dd"
            case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
            case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
            case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
            case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
            case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
            case .custom(let customFormat): return customFormat
            }
        }
    }
    
    func toDate(_ format: DateFormatType = .isoDate) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        return date
    }
    
    
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public var isValidEmail: Bool {
        return regexValidation(.emailPattern)
    }
    
    func regexValidation(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> Bool{
        do {
            return try NSRegularExpression(pattern: pattern, options: options).firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
}

extension String{
    
    var addDecimal: String{
        return String(format: "%.2f", Double(self) ?? 0)
    }
    static let empty = ""
    
}
