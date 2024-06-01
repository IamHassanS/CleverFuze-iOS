//
//  Extension + CGFloat.swift
//  CleverFuze
//
//  Created by Anil Kumar on 01/08/22.
//

import UIKit

extension CGFloat{
    
    static let screenHeight = UIScreen.main.bounds.height
    
    static let screenWidth  = UIScreen.main.bounds.width
    
    static func ratioHeightBasedOniPhoneX(_ val: CGFloat) -> CGFloat{
        return val//self.screenHeight * (val/812)
    }
    static func ratioWidthBasedOniPhoneX(_ val: CGFloat) -> CGFloat{
        return val//self.screenWidth * (val/375)
    }
    
    static func factionHeightBasedOnScreen(_ val: CGFloat) -> CGFloat{
        return self.screenHeight * val
    }
    static func factionWidthBasedOnScreen(_ val: CGFloat) -> CGFloat{
        return self.screenWidth * val
    }
    
}
