//
//  CFChartDescriptionView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 19/09/22.
//

import UIKit

class CFChartDescriptionView: UIView {

    lazy var labelChartDesc: UILabel! = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .setFont(.regular, size: .ratioHeightBasedOniPhoneX(9))
        label.text = ""
        label.numberOfLines = 2
        return label
        
    }()
    
    lazy var viewDesc: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFChartDescriptionView{
    
    func addConstraint(){
        
        self.addSubview(self.viewDesc)
        self.addSubview(self.labelChartDesc)
        
        NSLayoutConstraint.activate([

            self.viewDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewDesc.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.viewDesc.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(15)),
            self.viewDesc.heightAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(15)),

            self.labelChartDesc.leadingAnchor.constraint(equalTo: self.viewDesc.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(15)),
            self.labelChartDesc.centerYAnchor.constraint(equalTo: self.viewDesc.centerYAnchor),
            self.labelChartDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
        self.viewDesc.layoutIfNeeded()
        self.labelChartDesc.layoutIfNeeded()
    }
    
}
