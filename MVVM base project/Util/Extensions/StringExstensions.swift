//
//  StringExstensions.swift
//  remoney2-ios-shops
//
//  Created by Ljubo Maricevic on 06/05/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func convertStringDateToString(currentFormat: String? = "yyyy-MM-dd'T'HH:mm:ssZ", outputFormat: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        let dateStr = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: dateStr)
    }
  
}

extension Date{
    
      func convertDateToString(currentFormat: String? = "yyyy-MM-dd'T'HH:mm:ssZ", outputFormat: String) -> String{
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = currentFormat
          let date = dateFormatter.string(from: self)
          let dateStr = dateFormatter.date(from: date)
          dateFormatter.dateFormat = outputFormat
          return dateFormatter.string(from: dateStr!)
      }
      
}

extension NSAttributedString {
    func attributedStringWithResizedImages(with maxWidth: CGFloat) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
            if let attachement = value as? NSTextAttachment {
                let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
                if image.size.width > maxWidth {
                    let newImage = image.resizeImage(scale: maxWidth/image.size.width)
                    let newAttribut = NSTextAttachment()
                    newAttribut.image = newImage
                    text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
                }
            }
        })
        return text
    }
}

extension UIImage {
    func resizeImage(scale: CGFloat) -> UIImage {
        let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)

        UIGraphicsBeginImageContext(newSize)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension NSMutableAttributedString
{
    func convertFontTo(font: UIFont)
    {
        var range = NSMakeRange(0, 0)

        while (NSMaxRange(range) < length)
        {
            let attr = attributes(at: NSMaxRange(range), effectiveRange: &range)
            if let oldFont = attr[NSAttributedString.Key.font]
            {
                let newFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits((oldFont as AnyObject).fontDescriptor.symbolicTraits) ?? UIFontDescriptor(name: "Roboto-Light", size: 15.0), size: font.pointSize)
                addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
            }
        }
    }
}
extension String {
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
//        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
//        }
    }
    
    func prepareForSafari() -> String{
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    func stringByAddingPercentEncodingForRFC3986() -> String {
      let unreserved = "-._~/?"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)
      return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) ?? ""
    }
}

extension String {
 
    func getDaysIntervalSince() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
        let date = (dateFormatter.date(from: self)?.timeIntervalSinceNow)! * -1
        return Int((date / 60 / 60 / 24).truncate(places: 0))
    }
    
    func getTimeIntervalSince() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = (dateFormatter.date(from: self)?.timeIntervalSinceNow)! * -1
        if (date / 60) <= 1{
            return "1 " + "minute-ago".localized()
        }
        else if (date / 60) < 60 && (date / 60) > 1 {
            if (date / 60) < 2{
                return "\(Int((date/60).truncate(places: 0))) " + "minute-ago".localized()
            }
            return "\(Int((date/60).truncate(places: 0))) " + "minutes-ago".localized()
        }
        else if (date / 60 / 60) < 24{
            if (date / 60 / 60) < 2{
                return "\(Int((date / 60 / 60).truncate(places: 0))) " + "hour-ago".localized()
            }
            return "\(Int((date / 60 / 60).truncate(places: 0))) " + "hours-ago".localized()
        }
        else if (date / 60 / 60 / 24) < 30{
            if (date / 60 / 60 / 24) < 2{
                return "\(Int((date / 60 / 60 / 24).truncate(places: 0))) " + "day-ago".localized()
            }
            return "\(Int((date / 60 / 60 / 24).truncate(places: 0))) " + "days-ago".localized()
        }
        else if (date / 60 / 60 / 24 / 30) < 12{
            if (date / 60 / 60 / 24 / 30) < 2{
                return "\(Int((date / 60 / 60 / 24 / 30).truncate(places: 0))) " + "month-ago".localized()
            }
            return "\(Int((date / 60 / 60 / 24 / 30).truncate(places: 0))) " + "months-ago".localized()
        }
        else{
            return "\(Int((date / 60 / 60 / 24 / 30 / 12).truncate(places: 0))) " + "years-ago".localized()
        }
    }
}
    
extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}


extension String{
    func convertMonthToImage() -> UIImage{
        switch self{
        case "01":
            return UIImage(named: "januar")!
        case "02":
            return UIImage(named: "februar")!
        case "03":
            return UIImage(named: "mart")!
        case "04":
            return UIImage(named: "april")!
        case "05":
            return UIImage(named: "maj")!
        case "06":
            return UIImage(named: "jun")!
        case "07":
            return UIImage(named: "jul")!
        case "08":
            return UIImage(named: "avgust")!
        case "09":
            return UIImage(named: "septembar")!
        case "10":
            return UIImage(named: "oktobar")!
        case "11":
            return UIImage(named: "novembar")!
        case "12":
            return UIImage(named: "decembar")!
        
        default:
            return UIImage(named: "januar")!
        }
    }
}
