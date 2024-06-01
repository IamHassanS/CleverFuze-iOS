//
//  CFDocumentUploadTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 11/10/22.
//

import UIKit

class CFDocumentUploadTableViewCell: CFEntryFieldTableViewCell {

    weak var documentDelegate: CFDocumentDelegate?
    private var originalURL: URL?
    var didSelectDocument: Bool = false
            
    override var values: Any? {
        didSet {
            if let url = values as? URL {
                self.textField.text = url.lastPathComponent
                self.originalURL = url
            } else if let urlString = values as? String, let url = URL(string: urlString) {
                self.textField.text = url.lastPathComponent
                self.originalURL = url
            } else {
                self.originalURL = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFDocumentUploadTableViewCell{
    
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let url = originalURL {
            // Open the URL in a web view or similar
            DispatchQueue.main.async {
                self.openWebPage(url)
            }
        } else {
            // Open the document picker
            if self.didSelectDocument{
                self.documentDelegate?.openDocument(fieldType ?? .fileInput(0))
            }
        }
        return false
    }
    
    private func openWebPage(_ url: URL) {
        let webViewController = CFWebViewController()
        webViewController.url = url
        self.viewController?.present(webViewController, animated: true, completion: nil)
    }
    
    // Utility to get the view controller that the cell is contained within
    private var viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            if let vc = nextResponder as? UIViewController {
                return vc
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
}
