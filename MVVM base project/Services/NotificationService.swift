//
//  NotificationService.swift
//  ZRKB
//
//  Created by Ljubo Maricevic on 03/10/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import KeychainSwift
import Moya
import Localize_Swift

class NotificationService {
    
    static let shared = NotificationService()

    let keychain = KeychainSwift()
       
    var provider: MoyaProvider<NetworkApi>!
    private let disposeBag = DisposeBag()

    
    var fcmToken: String {
        get {
            if fcmTokenVal.isEmpty { fcmTokenVal = keychain.get("FCM_TOKEN") ?? "" }
            return fcmTokenVal
        }
        set {
            fcmTokenVal = newValue
            keychain.set(newValue, forKey: "FCM_TOKEN")
        }
    }
    
    
    private var fcmTokenVal: String = ""

    private init() {}
   
}
