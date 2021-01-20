//
//  AuthCoordinator.swift
//  ZRKB
//
//  Created by Ljubo Maricevic on 19/08/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import XCoordinator
import Moya
import CoreLocation

enum AuthRoute: Route{
    case login
    case cls
    case next
}

class AuthCoordinator: NavigationCoordinator<AuthRoute> {
    
    var provider: MoyaProvider<NetworkApi> = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])

    init(_ provider: MoyaProvider<NetworkApi>, initialRoute: AuthRoute? = .login){
        super.init(initialRoute: initialRoute)
    }

    override func prepareTransition(for route: AuthRoute) -> NavigationTransition {
        switch route {
        case .login:
            let viewController = LoginVC.instantiateFromNib()
            let viewModel: LoginVM = LoginVM(provider: provider)
            let rxVC: LoginRx = LoginRx(vc: viewController)
            viewModel.router = weakRouter
            viewController.bind(to: rxVC)
            rxVC.bind(to: viewModel)
            return .push(viewController)
        case .cls:
            return .dismiss()
        case .next:
            let coordinator = AnotherCoordinator(provider)
            coordinator.viewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
        }
    }
    
}
