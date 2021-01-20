//
//  SplashVM.swift
//  ZRKB
//
//  Created Ljubo Maricevic on 19/08/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import XCoordinator

class SplashVM: ViewModel {

    var router: WeakRouter<AppRoute>!
    private var provider: MoyaProvider<NetworkApi>!
    var disposeBag = DisposeBag()
    
    init(provider: MoyaProvider<NetworkApi>) {
        self.provider = provider
    }
    
    var obs: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    func printWelcome(){
        self.obs.accept("WELCOME")
    }
  
    func gotoMain(){
//        ViewModel.shared.networkRequest(provider: self.provider, disposeBag: self.disposeBag, networkApi: .games, model: User.self) { [weak self] (res) in
////            self?.singleVoucherResponse.accept(res)
//        }

    }
    
    func gotoAuth(){
        self.router.trigger(.auth)
    }
}
