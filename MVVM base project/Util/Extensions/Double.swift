//
//  Double.swift
//  remoney2-ios-shops
//
//  Created by User on 08/05/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation

extension Double {
    func currencyAmount() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyGroupingSeparator = ""
        currencyFormatter.currencySymbol = ""
        currencyFormatter.locale = Locale(identifier: "it_IT")
        
        return currencyFormatter.string(from: NSNumber(value: self))!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) + "€"
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
