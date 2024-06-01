//
//  CFTotalRecordListView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

class CFTotalRecordListView: UIView {

    lazy var serialNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    lazy var titleLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
        
    }()

    lazy var actionLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(16))
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Action"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
        
    }()
    
    lazy var buttonView: UIButton! = {
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: .ratioWidthBasedOniPhoneX(48), height: .ratioWidthBasedOniPhoneX(48)))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.buttonViewAction), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "eye"), for: [.normal])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    weak var delegateDamageitem: CFDockDetailControllerDelegate?
    
    var data: CFRecordDataSource?{
        didSet{
            self.setValue()
        }
    }
    
    var delegate: CFRecordDataHandlerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFTotalRecordListView{
    
    func setView(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
    }
    
    func setConstraint(){
        
        self.addSubview(self.serialNumberLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.actionLabel)
        self.addSubview(self.buttonView)
        
        NSLayoutConstraint.activate([
        
            self.serialNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(15)),
            self.serialNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.serialNumberLabel.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -.ratioWidthBasedOniPhoneX(8)),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(70)),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.serialNumberLabel.centerYAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.actionLabel.leadingAnchor, constant: -.ratioWidthBasedOniPhoneX(8)),

            self.actionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(8)),
            self.actionLabel.centerYAnchor.constraint(equalTo: self.serialNumberLabel.centerYAnchor),
            self.actionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(17)),
            self.actionLabel.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(60)),
            
            self.buttonView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(25)),
            self.buttonView.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(22)),
            self.buttonView.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(22)),

        ])
        

    }
    
}

extension CFTotalRecordListView{
    
    func setView(_ font: UIFont?, isHeader: Bool){
        self.serialNumberLabel.font = font
        self.titleLabel.font = font
        self.actionLabel.font = font
        self.actionLabel.text = "Action"
        self.actionLabel.isHidden = !isHeader
        self.buttonView.isHidden = isHeader
    }
    
}

extension CFTotalRecordListView{
    
    func setValue(){
        self.buttonView.isHidden = ((self.data as? CFReportCountTableDatum) != nil)
        self.actionLabel.isHidden = ((self.data as? CFReportCountTableDatum) == nil)
        self.actionLabel.text = (self.data as? CFReportCountTableDatum)?.count?.stringValue ?? "" //?.dollarValue ?? ""
        self.titleLabel.text = self.data?.name
    }
    
}

extension CFTotalRecordListView{
    
    @objc
    func buttonViewAction(){
        StrongboxController.documentUrlData = nil
        self.delegate?.dataDidSelected(for: self.tag, data: self.data)
        
        guard let recordData = data else {
            return
        }
        
        let specificFields = recordData.getExistData([.damagaeMissingItems])
        
        if let id = extractNameFromJSON(specificFields) {
//            self.delegateDamageitem?.didReceiveDocumentData(name) { _ in 
//            }
        } else {
            StrongboxController.documentUrlData = nil
        }
    }
    
    func extractNameFromJSON(_ specificFields: [CFCustomFieldType: Any]) -> Int? {
        
        guard let damagaeMissingItems = specificFields[.damagaeMissingItems] as? CFDropDownValue, let name = damagaeMissingItems.id else {
            return nil
        }
        return name
    }
}    

protocol CFDockDetailControllerDelegate: AnyObject {
    func didReceiveDocumentData(_ documentData: Int?, _ completion: @escaping (Bool) -> Void)
}

protocol JSONSerializable {
    func toSerializable() -> Any
}


