//
//  CFDocumentDelegate.swift
//  CleverFuze
//
//  Created by Anil Kumar on 11/10/22.
//

import UIKit
import MobileCoreServices

protocol CFDocumentDelegate: AnyObject where Self: CFBaseViewController & UIDocumentPickerDelegate{
        
}

extension CFDocumentDelegate{
    
    func openDocument(_ fieldType: CFCustomFieldType){
        let documentPicker = CFDocumentPickerViewController(documentTypes: [String(kUTTypeText), String(kUTTypeContent), String(kUTTypeItem), String(kUTTypeData)], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        documentPicker.fieldType = fieldType
        self.present(documentPicker, animated: true, completion: nil)
    }
        
}

