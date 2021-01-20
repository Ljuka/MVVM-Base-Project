//
//  TextFieldExtensions.swift
//  GoPlant.me
//
//  Created by Ljubo Maricevic on 21/04/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder(borderColod: UIColor? = .black) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = borderColod?.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
