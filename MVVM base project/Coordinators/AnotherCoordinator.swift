//
//  AnotherCoordinator.swift
//  MVVM base project
//
//  Created by Ljubo Maricevic on 02/11/2020.
//

import Foundation
import XCoordinator
import Moya
import CoreLocation

enum AnotherRoute: Route{
    case reg
    case cls
    case next
}

class AnotherCoordinator: NavigationCoordinator<AnotherRoute> {
    
    var provider: MoyaProvider<NetworkApi> = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])

    init(_ provider: MoyaProvider<NetworkApi>, initialRoute: AnotherRoute? = .reg){
        super.init(initialRoute: initialRoute)
    }

    override func prepareTransition(for route: AnotherRoute) -> NavigationTransition {
        switch route {
        case .reg:
            let viewController = AnotherVC.instantiateFromNib()
            let viewModel: AnotherVM = AnotherVM(provider: provider)
            let rxVC: AnotherRx = AnotherRx(vc: viewController)
            viewModel.router = weakRouter
            viewController.bind(to: rxVC)
            rxVC.bind(to: viewModel)
            return .push(viewController)
        case .cls:
            return .dismiss()
        case .next:
            let coordinator = AuthCoordinator(provider)
            coordinator.viewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
        }
    }
    
}
