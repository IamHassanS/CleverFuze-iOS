//
//  CFReportRecordView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 04/10/22.
//

import UIKit

class CFReportRecordView: CFBaseRecordView  {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func setConstraint(){
        super.setConstraint()
        self.noRecordFoundLabel.removeFromSuperview()
        
        self.addSubview(self.tableView)

        self.tableViewHeightConstraint = self.tableView.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(565))
        
        NSLayoutConstraint.activate([
        
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -.ratioWidthBasedOniPhoneX(20)),
            self.tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tableViewHeightConstraint,
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioHeightBasedOniPhoneX(35)),

        ])
        
    }
    
}

extension CFReportRecordView{
    
    func setView(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
}
