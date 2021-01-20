//
//  LoginVM.swift
//  MVVM base project
//
//  Created Ljubo Maricevic on 02/11/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import XCoordinator

class LoginVM: ViewModel {

    var router: WeakRouter<AuthRoute>!
    private var provider: MoyaProvider<NetworkApi>!
    private let disposeBag = DisposeBag()
    
    init(provider: MoyaProvider<NetworkApi>) {
        self.provider = provider
    }
    
    func cls(){
        router.trigger(.cls)
    }
    
    func next(){
        router.trigger(.next)
    }
      
  
}
