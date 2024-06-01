//
//  Extension + UIView.swift
//  CleverFuze
//
//  Created by Anil Kumar on 27/08/22.
//

import UIKit

extension UIView{
    
    func setHeightConstraint(_ float: CGFloat){
        
        self.layer.cornerRadius = float/2
        self.heightAnchor.constraint(equalToConstant: float).isActive = true
        
    }
    
    func addGradientPageNumber(_ colors: [UIColor]){
        let layer = CAGradientLayer()
        layer.colors = colors.compactMap{$0.cgColor}
        layer.locations = [0, 0.64]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
        layer.position = self.center
        layer.masksToBounds = true
        self.layer.insertSublayer(layer, at: 0)
    }
    
}

@IBDesignable extension UIView{
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var viewCornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var shadowColor: UIColor {
        set {
            layer.shadowColor = newValue.cgColor
        }
        get {
            guard let color = layer.shadowColor else {
                return .clear
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    @IBInspectable var maskBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
}
