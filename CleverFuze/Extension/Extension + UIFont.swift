//
//  Extension + UIFont.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import UIKit

extension UIFont{
    
    enum CFFontFamily: String{
        
        case regular = "SourceSansPro-Regular"
        case italic = "SourceSansPro-It"
        case extraLight = "SourceSansPro-ExtraLight"
        case extraLightItalic = "SourceSansPro-ExtraLightIt"
        case light = "SourceSansPro-Light"
        case lightItalic = "SourceSansPro-LightIt"
        case semiBold = "SourceSansPro-Semibold"
        case semiBoldItalic = "SourceSansPro-SemiboldIt"
        case bold = "SourceSansPro-Bold"
        case boldItalic = "SourceSansPro-BoldIt"
        case black = "SourceSansPro-Black"
        case blackItalic = "SourceSansPro-BlackIt"

    }
    
    static func setFont(_ font: CFFontFamily, size: CGFloat) -> UIFont?{
        return .init(name: font.rawValue, size: .ratioHeightBasedOniPhoneX(size))
    }
    
}
