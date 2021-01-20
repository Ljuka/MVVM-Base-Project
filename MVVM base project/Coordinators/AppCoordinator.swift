//
//  AppCoordinator.swift
//  ZRKB
//
//  Created by Ljubo Maricevic on 19/08/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import XCoordinator
import Moya

enum AppRoute: Route {
    case splash
    case auth
    case another
} 

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    let provider = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin(), AuthPlugin(token: AuthService.shared.token)])
    
    init(route: AppRoute = .splash){
        super.init(initialRoute: route)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .splash:
            let viewController = SplashVC.instantiateFromNib()
            let viewModel: SplashVM = SplashVM(provider: provider)
            let rxVC: SplashRx = SplashRx(vc: viewController)
            viewModel.router = weakRouter
            viewController.bind(to: rxVC)
            rxVC.bind(to: viewModel)
            return .push(viewController)
        case .auth:
            let coordinator = AuthCoordinator(provider)
            coordinator.viewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
        case .another:
            let coordinator = AnotherCoordinator(provider)
            coordinator.viewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
        
        
        }
    }
    
}
