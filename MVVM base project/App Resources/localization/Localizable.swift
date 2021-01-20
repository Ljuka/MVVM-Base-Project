//
//  Localizable.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 24/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

public protocol XIBLocalizable {
    func reloadLocalizedLabel()
}

public protocol XIBSingleLocalizable: XIBLocalizable {
    var localizationKey: String? { get set }
}

public protocol XIBMultiLocalizable: XIBLocalizable {
    var localizationKeys: String? { get set }
}

extension UILabel: XIBSingleLocalizable {
    @IBInspectable public var localizationKey: String? {
        get { return nil }
        set(key) {
            self.key = key ?? ""
            text = key?.localized()
        }
    }
    
    private static var _storedProperty = [String:String]()
    
    var key: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UILabel._storedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UILabel._storedProperty[tmpAddress] = newValue
        }
    }
    
    public func reloadLocalizedLabel() { text = key.localized() }
}

extension UIButton: XIBSingleLocalizable {
    @IBInspectable public var localizationKey: String? {
        get { return nil }
        set(key) {
            self.key = key ?? ""
            setTitle(key?.localized(), for: .normal)
        }
    }
    
    private static var _storedProperty = [String:String]()
    
    var key: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIButton._storedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIButton._storedProperty[tmpAddress] = newValue
        }
    }
    
    public func reloadLocalizedLabel() { setTitle(key.localized(), for: .normal) }
}

extension UINavigationItem: XIBSingleLocalizable {
    @IBInspectable public var localizationKey: String? {
        get { return nil }
        set(key) {
            self.key = key ?? ""
            title = key?.localized()
        }
    }
    
    private static var _storedProperty = [String:String]()
    
    var key: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UINavigationItem._storedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UINavigationItem._storedProperty[tmpAddress] = newValue
        }
    }
    
    public func reloadLocalizedLabel() { title = key.localized() }
}

extension UIBarItem: XIBSingleLocalizable { // Localizes UIBarButtonItem and UITabBarItem
    @IBInspectable public var localizationKey: String? {
        get { return nil }
        set(key) {
            self.key = key ?? ""
            title = key?.localized()
        }
    }
    
    private static var _storedProperty = [String:String]()
    
    var key: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIBarItem._storedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIBarItem._storedProperty[tmpAddress] = newValue
        }
    }
    
    public func reloadLocalizedLabel() { title = key.localized() }
}

extension UISegmentedControl: XIBMultiLocalizable {
    @IBInspectable public var localizationKeys: String? {
        get { return nil }
        set(keys) {
            self.keys = keys ?? ""
            guard let keys = keys?.components(separatedBy: ","), !keys.isEmpty else { return }
            for (index, title) in keys.enumerated() {
                setTitle(title.localized(), forSegmentAt: index)
            }
        }
    }
    
    private static var _storedProperty = [String:String]()
    
    var keys: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UISegmentedControl._storedProperty[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UISegmentedControl._storedProperty[tmpAddress] = newValue
        }
    }
    
    public func reloadLocalizedLabel() {
        let keysSeparated = keys.components(separatedBy: ",")
        if keysSeparated.isEmpty { return }
        for (index, title) in keysSeparated.enumerated() {
            setTitle(title.localized(), forSegmentAt: index)
        }
    }
}

extension UIViewController {
    func reloadLocalizedLabels(localizedView: UIView){
        for labeledView in localizedView.subviews {
            if labeledView is XIBLocalizable {
                (labeledView as! XIBLocalizable).reloadLocalizedLabel()
            }
            else{
                reloadLocalizedLabels(localizedView: labeledView)
            }
        }
    }
}
