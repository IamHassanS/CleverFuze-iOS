//
//  CFChartTableViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 16/09/22.
//

import UIKit

class CFChartTableViewCell: CFEntryBaseTableViewCell {

    lazy var chartView: CFChartView! = {
        
        let chartView = CFChartView()
        return chartView
        
    }()
    
    override var values: Any?{
        didSet{
            self.chartView.value = self.values
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFChartTableViewCell{
    
    func addConstraint(){
        
        self.contentView.addSubview(self.chartView)
        
        NSLayoutConstraint.activate([
        
            self.chartView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .ratioWidthBasedOniPhoneX(28)),
            self.chartView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(28)),
            self.chartView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(28)),
            self.chartView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(28)),

        ])
        self.chartView.layoutIfNeeded()
    }
    
}
