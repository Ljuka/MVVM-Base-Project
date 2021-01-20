////
////  DetailsCoordinator.swift
////  Quarantine App
////
////  Created by Ljubo Maricevic on 28/05/2020.
////  Copyright © 2020 Ljubo Maricevic. All rights reserved.
////
//
//import Foundation
//import XCoordinator
//import Moya
//import RxSwift
//import RxCocoa
//
//enum PetiRoute: Route{
//    case peti
//    case auth
//}
//
//var ruter: BehaviorRelay<UnownedRouter<PetiRoute>?> = BehaviorRelay<UnownedRouter<PetiRoute>?>(value: nil)
////var opened2ndTime: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: nil)
//var opened2ndTime: Bool? = false
//
//class PetiCoordinator: NavigationCoordinator<PetiRoute> {
//    
//    let provider: MoyaProvider<NetworkApi> = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose)), AuthPlugin(token: AuthService.shared.token)])
//    
//    init(_ provider: MoyaProvider<NetworkApi>){
//        super.init(initialRoute: .peti)
//    }
//
//    override func prepareTransition(for route: PetiRoute) -> NavigationTransition {
//        switch route {
//        case .peti:
//            ruter.accept(unownedRouter)
//            return .none()
//        case .auth:
//            let coordinator = AuthCoordinator(provider)
//            coordinator.viewController.modalPresentationStyle = .fullScreen
//            return .present(coordinator)
//        }
//    }
//    
//}
