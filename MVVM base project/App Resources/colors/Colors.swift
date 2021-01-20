//
//  Colors.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 12/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var azureBlue: UIColor {
        return UIColor(hex: "#43BEE1")
    }
    
    @nonobjc class var mainGold: UIColor {
        return UIColor(hex: "#D7B369")
    }
    
    @nonobjc class var greyText: UIColor {
        return UIColor(hex: "#ABB4BD")
    }
    
    @nonobjc class var buttonText: UIColor {
      return UIColor(hex: "#004270")
    }
    
    @nonobjc class var darkText: UIColor {
      return UIColor(hex: "#1D2029")
    }
    
    @nonobjc class var disabledGrey: UIColor {
      return UIColor(hex: "#D9DDE2")
    }
    
    @nonobjc class var veryLightPink: UIColor {
      return UIColor(hex: "#F7F7F7")
    }
    
    @nonobjc class var textColor: UIColor {
      return UIColor(hex: "#3B4C58")
    }
    
    
    ////////////////////////
//    @nonobjc class var mainGold: UIColor {
//        return UIColor(hex: "#BF9869")
//    }
    
    @nonobjc class var outlineFill: UIColor {
        return UIColor(hex: "#FAFAFA")
    }
    
    @nonobjc class var mainGrey: UIColor {
        return UIColor(hex: "#999999")
    }
    
    @nonobjc class var backgroundGrey: UIColor {
        return UIColor(hex: "#EBEBEB")
    }
    
    @nonobjc class var boldText: UIColor {
        return UIColor(hex: "#333333")
    }
    
//    @nonobjc class var disabledGrey: UIColor {
//        return UIColor(hex: "#666666")
//    }
    
    @nonobjc class var checkboxBorder: UIColor {
        return UIColor(hex: "#DADADA")
    }
    
    @nonobjc class var checkboxFill: UIColor {
        return UIColor(hex: "#F9F9F9")
    }
    
    @nonobjc class var borderGrey: UIColor {
        return UIColor(hex: "#CCCCCC")
    }
    
//    @nonobjc class var coral: UIColor {
//      return UIColor(red: 251.0 / 255.0, green: 89.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
//    }


}

extension UIColor {
    convenience init(hex: String){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
}
