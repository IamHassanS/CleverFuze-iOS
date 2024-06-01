//
//  CFButton.swift
//  CleverFuze
//
//  Created by Anil Kumar on 26/08/22.
//

import UIKit

class CFButton: UIButton {

    var buttonVariety: CFButtonVariety?{
        didSet{
            self.setValue()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addGradientValue()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CFButton{
    
    func setValue(){
        self.setTitle(buttonVariety?.rawValue, for: [.normal])
        self.setImage(buttonVariety?.buttonImage, for: [.normal])
        self.titleLabel?.font = self.buttonVariety?.buttonFont
        self.backgroundColor = self.buttonVariety?.backGroundColor
    }
    
    func addGradientValue(){
        guard let colors = self.buttonVariety?.gradientColors, !colors.isEmpty else {
            self.backgroundColor = self.buttonVariety?.backGroundColor
            return
        }
        self.addGradient(colors)
    }
    
}

extension CFButton{
    
    func setView(){
        self.clipsToBounds = true
        self.setTitleColor(.white, for: [.normal])
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
    
}

extension CFButton{
    
    func addGradient(_ colors: [CGColor]){
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.42, b: 0.86, c: -0.86, d: 24.32, tx: 0.18, ty: -12.16))
        layer.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
        layer.position = self.center
        layer.masksToBounds = true
        self.layer.insertSublayer(layer, at: 0)
    }

}

