//
//  CFErrorMessage.swift
//  CleverFuze
//
//  Created by Anil Kumar on 25/08/22.
//

import Foundation

struct CFErrorMessage{
    
    static let connectionLost = "Your internet connection is lost. Please try again."
    static let timeout = "Unable to connect with the server. Would you like to retry?"
    static let noInternet = "Please check your internet connection and try agian."
    static let requestCancelled = "Request cancelled"
    static let defaultError = "There was a problem with our server. Please try after sometime."
    static let dataDecodeError = "Data Decode Error"
    static let dataNotFound = "Data not found"
    static let underMaintance = "We are under maintenance now. Please come back later."
    static let unAuthorized = "unAuthorized"
    static let requiredField = "Please enter all required field"
}

enum ErrorData: String {
    
    case emptyEmail = "Enter your email"
    case validEmail = "Enter a valid email"
    case emptyPassword = "Enter your password"
    case invalidEmailID = "invalidEmailID"
    case invalidEmailOrPassword = "Invalid username or password"
    case fieldError = "This field is required"
    case ZipError = "Please enter 5-digit ZIP code"
    case requiredField = "Please enter the required field"
    case Zonedelete = "Zone delet sucessfully"
    case ValidZone = "Enter valid Zone"
    case newpasswordandconfirm = "The newpassword must be at least 8 characters"
}
