//
//  CFPageNumberCollectionViewCell.swift
//  CleverFuze
//
//  Created by Anil Kumar on 29/08/22.
//

import UIKit

class CFPageNumberCollectionViewCell: UICollectionViewCell {
    
    lazy var pageNumberLabel: UILabel! = {
        
        let label = UILabel()
        label.font = .setFont(.regular, size: .ratioWidthBasedOniPhoneX(13))
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var gradientLayerView: UIView! = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setConstraint()
        
        //
        self.setGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFPageNumberCollectionViewCell{
    
    func setGradient(){
        DispatchQueue.main.async { [weak self] in
            self?.gradientLayerView.addGradientPageNumber([.pageGradientFirstColor, .secondaryColor])
            self?.gradientLayerView.layer.cornerRadius = .ratioHeightBasedOniPhoneX(11)
        }
    }
    
}

extension CFPageNumberCollectionViewCell{
    
    func setView(){
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    func setConstraint(){
        
        self.contentView.addSubview(self.gradientLayerView)
        self.contentView.addSubview(self.pageNumberLabel)

        NSLayoutConstraint.activate([
        
            self.gradientLayerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.gradientLayerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.gradientLayerView.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(22)),
            self.gradientLayerView.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(22)),

            self.pageNumberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.pageNumberLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.pageNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.pageNumberLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

        ])
        
    }
    
}
