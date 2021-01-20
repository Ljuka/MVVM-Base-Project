//
//  AuthService.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 11/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import KeychainSwift
import Moya
import Localize_Swift

class AuthService {

    static let shared = AuthService()

    let keychain = KeychainSwift()

    var userID: String {
        get {
            if user_id.isEmpty { user_id = keychain.get("USER_ID") ?? "" }
            return user_id
        }
        set {
            user_id = newValue
            keychain.set(newValue, forKey: "USER_ID")
        }
    }

    var refreshTokenStr: String {
        get {
            if pass.isEmpty { pass = keychain.get(REFRESH) ?? "" }
            return pass
        }
        set {
            pass = newValue
            keychain.set(newValue, forKey: REFRESH)
        }
    }

    var token: String {
        get {
            if mToken.isEmpty { mToken = keychain.get(TOKEN) ?? "" }
            return mToken
        }
        set {
            mToken = newValue
            keychain.set(newValue, forKey: TOKEN)
        }
    }
     
    private var mToken: String = ""
    private var user_id: String = ""
    private var pass: String = ""
    var isRefreshed: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    private init() {}
    
    func refreshToken() -> Observable<Bool>{
        return Observable.create { (observer) -> Disposable in
            let provider = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])

            provider.request(.refreshToken, completion: {result in
                switch result{
                case let .success(response):
                    let data = Data(response.data)
                    let decoder = JSONDecoder()
    //                let tokenResponse = try? decoder.decode(User.self, from: data)
    //                self.token = tokenResponse?.jwt ?? ""
    //                AuthService.shared.token = tokenResponse?.jwt ?? ""
    //                AuthService.shared.refreshTokenStr = tokenResponse?.refreshToken ?? ""
                    observer.onNext(true)
                    observer.onCompleted()
                case .failure(_):
                    observer.onNext(false)
            }
        })

            return Disposables.create()
        }
   
    }

}
