//
//  CFChartView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 16/09/22.
//

import UIKit
import PieCharts

class CFChartView: UIView {
    var model: [Double] = [] // Add this variable to store your model data

    lazy var firstDesc: CFChartDescriptionView = {
        
        let view = CFChartDescriptionView()
        view.viewDesc.backgroundColor = .primaryColor
        view.labelChartDesc.text = "Total Income"
        return view
        
    }()
    
    lazy var secondDesc: CFChartDescriptionView = {
        
        let view = CFChartDescriptionView()
        view.viewDesc.backgroundColor = .appYellowColor
        view.labelChartDesc.text = "Total Income for selective record"
        return view
        
    }()
    
    lazy var chartView: PieChart! = {
        
        let chartView = PieChart()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        // order is important - models have to be set at the end
        return chartView
        
    }()
    
    var value: Any?{
        didSet{
            let model = (self.value as? [Double] ?? [])
            self.firstDesc.labelChartDesc.text = "Total Income: $\(model.first ?? 0)"
            self.secondDesc.labelChartDesc.text = "Total Income for selective record: $\(model.last ?? 0)"
            self.layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.addConstraint()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setChartView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CFChartView{
    
    func setView(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
    }
    
    func addConstraint(){
        
        self.addSubview(self.firstDesc)
        self.addSubview(self.secondDesc)
        self.addSubview(self.chartView)

        NSLayoutConstraint.activate([
        
            self.firstDesc.topAnchor.constraint(equalTo: self.topAnchor),
            self.firstDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.firstDesc.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(30)),
            self.firstDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.secondDesc.topAnchor.constraint(equalTo: self.firstDesc.bottomAnchor),
            self.secondDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.secondDesc.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(30)),
            self.secondDesc.trailingAnchor.constraint(equalTo: self.firstDesc.trailingAnchor),

            self.chartView.topAnchor.constraint(equalTo: self.secondDesc.bottomAnchor, constant: .ratioWidthBasedOniPhoneX(60)),
            self.chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.ratioWidthBasedOniPhoneX(28)),
            self.chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(28)),
            self.chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.ratioWidthBasedOniPhoneX(16)),
            self.chartView.heightAnchor.constraint(equalToConstant: .factionWidthBasedOnScreen(0.7)),
            self.chartView.widthAnchor.constraint(equalToConstant: .factionWidthBasedOnScreen(0.7)),

        ])
        self.chartView.layoutIfNeeded()
    }

}

extension CFChartView{
    func setChartView() {
        chartView.clear()
        let firstDescText = self.firstDesc.labelChartDesc.text ?? ""
        let secondDescText = self.secondDesc.labelChartDesc.text ?? ""
          chartView.layers = [createPlainTextLayer(firstDescText: firstDescText, secondDescText: secondDescText), createTextWithLinesLayer()]
          chartView.delegate = self
          chartView.models = createModels()
      }
}

extension CFChartView{
    
    // MARK: - Models
    fileprivate func createModels() -> [PieSliceModel] {
        let models = (self.value as? [Double] ?? []).enumerated().compactMap { (index, value) in
            let color: UIColor = (index == 0) ? .primaryColor : .appYellowColor
            return PieSliceModel(value: value, color: color)
        }

        return models
    }

    // MARK: - Layers
    private func createPlainTextLayer(firstDescText: String, secondDescText: String) -> PiePlainTextLayer {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = false
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)

        textLayerSettings.label.textGenerator = { slice in
            if slice.data.id < self.model.count {
                return String(format: "$%.2f", self.model[slice.data.id])
            } else if slice.data.id == self.model.count {
                return firstDescText
            } else {
                return secondDescText
            }
        }

        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }

    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.clear
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            return ""
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
    
}

extension CFChartView: PieChartDelegate{
    
    func onSelected(slice: PieCharts.PieSlice, selected: Bool) {
        
    }
}
