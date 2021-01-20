//
//  NavigationBarExtensions.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 22/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationBar {
    
    func setNavigationBarColor(color: UIColor) {
        self.backgroundColor = color
        self.barTintColor = color
        self.isTranslucent = false
    }
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = .clear
        self.barTintColor = .clear
    }
    
    func setNavigationTextColor(color: UIColor){
        self.tintColor = color
    }
    
}

extension UINavigationItem{
    func setNavigationImageTitle(image: UIImage){
        let imageView = UIImageView(image:image)
        self.titleView = imageView
    }
}
