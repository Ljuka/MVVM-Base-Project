//
//  MainCoordinator.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 11/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//


import Foundation
import XCoordinator
import Moya
//
//enum MainRoute: Route {
//    case stats
//    case news
//    case stayHome
//    case numbers
//    case peti
//}
//
//class MainCoordinator: TabBarCoordinator<MainRoute>{
//
//    // MARK: Stored properties
//
//    private let statsRouter: StrongRouter<StatRoute>
//    private let newsRouter: StrongRouter<NewsRoute>
//    private let stayHomeRouter: StrongRouter<StayHomeRoute>
//    private let numbersRouter: StrongRouter<NumbersRoute>
//    private let petiRouter: StrongRouter<PetiRoute>
//
//    // MARK: Initialization
//    let provider: MoyaProvider<NetworkApi> = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose)), AuthPlugin(token: AuthService.shared.token)])
//    
//    let rootViewControllerDelegate: MyCustomDelegate
//
//    
//    
//    convenience init() {
//        let provider: MoyaProvider<NetworkApi> = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose)), AuthPlugin(token: AuthService.shared.token)])
//        
//        let statsCoordinator = StatisticsCoordinator(provider)
//        statsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "Group 373"), selectedImage: #imageLiteral(resourceName: "Group 373-1"))
//        statsCoordinator.rootViewController.tabBarItem.tag = 0
//        let newsCoordinator = NewsCoordinator(provider)
//        newsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "calendar"), selectedImage: #imageLiteral(resourceName: "calendar-1"))
//        newsCoordinator.rootViewController.tabBarItem.tag = 1
//        
//        let stayHomeCoordinator = StayHomeCoordinator(provider)
//        stayHomeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "neaktivno"), selectedImage: #imageLiteral(resourceName: "aktivno"))
//        stayHomeCoordinator.rootViewController.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
//        newsCoordinator.rootViewController.tabBarItem.tag = 2
//        
//        let numbersCoordinator = NumbersCoordinator(provider)
//        numbersCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "football-ball"), selectedImage: #imageLiteral(resourceName: "Group 314-1"))
//        let petiCoordinator = PetiCoordinator(provider)
//        newsCoordinator.rootViewController.tabBarItem.tag = 3
//        
//        petiCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "Component 8 – 2"), selectedImage: #imageLiteral(resourceName: "Component 8 – 2"))
//        petiCoordinator.rootViewController.tabBarItem.tag = 5
//        
//        self.init(statsRoute: statsCoordinator.strongRouter, newsRoute: newsCoordinator.strongRouter, stayHomeRoute: stayHomeCoordinator.strongRouter, numbersRoute: numbersCoordinator.strongRouter, petiRoute: petiCoordinator.strongRouter)
//        
//    }
//
//    init(statsRoute: StrongRouter<StatRoute>,
//         newsRoute: StrongRouter<NewsRoute>,
//         stayHomeRoute: StrongRouter<StayHomeRoute>,
//         numbersRoute: StrongRouter<NumbersRoute>,
//         petiRoute: StrongRouter<PetiRoute>) {
//        
//        self.statsRouter = statsRoute
//        self.newsRouter = newsRoute
//        self.stayHomeRouter = stayHomeRoute
//        self.numbersRouter = numbersRoute
//        self.petiRouter = petiRoute
//        
//        let rootViewController = UITabBarController()
//        self.rootViewControllerDelegate = MyCustomDelegate()
//        rootViewController.delegate = rootViewControllerDelegate
//        
//        super.init(rootViewController: rootViewController, tabs: [statsRoute, newsRoute, stayHomeRoute, numbersRoute, petiRoute], select: stayHomeRoute)
////        (tabs: [statsRoute, newsRoute, stayHomeRoute, numbersRoute, petiRoute], select: statsRoute)
//        
//        self.setupCurvedTabBar()
//        
//
//        
//    }
//    
//    
//    
//    override func prepareTransition(for route: MainRoute) -> TabBarTransition {
//        switch route {
//        case .stats:
//            return .select(statsRouter)
//        case .news:
//            return .select(newsRouter)
//        case .stayHome:
//            return .select(stayHomeRouter)
//        case .numbers:
//            return .select(numbersRouter)
//        case .peti:
//            return .none()
//        }
//    }
//    
////    MARK: CURVED TAB BAR
//    func setupCurvedTabBar(){
////        
//        self.rootViewController.tabBar.items?.first?.title = ""
//        
//        self.rootViewController.tabBar.backgroundColor = .clear
//        self.rootViewController.tabBar.backgroundImage = UIImage.from(color: .clear)
//        self.rootViewController.tabBar.shadowImage = UIImage()
//        
//        let screenSize = UIScreen.main.bounds
//        let screenWidth = screenSize.width
//
//        let imgView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 48))
//        if self.rootViewController.tabBar.selectedItem?.tag != 5{
//            let v = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth / 2, height: 2))
//            v.backgroundColor = .azureBlue
//            imgView.backgroundColor = .clear
//            imgView.addSubview(v)
//        }
//        rootViewController.tabBar.selectionIndicatorImage = UIImage(view: imgView)
//        var modelName = UIDevice.modelName
//        if let range = modelName.range(of: "Simulator ") {
//            modelName.removeSubrange(range)
//        }
//        let oldModels = ["iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 6s", "iPhone 6s Plus", "iPhone SE", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone SE (2nd generation)"]
//
//        let fillerView = UIView()
//        fillerView.translatesAutoresizingMaskIntoConstraints = false
//        if oldModels.contains(modelName){
//              fillerView.frame = CGRect(x: self.rootViewController.tabBar.frame.minX, y: self.rootViewController.tabBar.frame.minY, width: self.rootViewController.tabBar.frame.width, height: self.rootViewController.tabBar.frame.height)
//          }
//          else{
//              fillerView.frame = CGRect(x: self.rootViewController.tabBar.frame.minX, y: self.rootViewController.tabBar.frame.minY - 36, width: self.rootViewController.tabBar.frame.width, height: self.rootViewController.tabBar.frame.width + 50)
//
//          }
//        
//        fillerView.roundCorners(corners: [.topLeft, .topRight], radius: 4)
//        fillerView.backgroundColor = #colorLiteral(red: 0, green: 0.2470588235, blue: 0.4235294118, alpha: 1)
//        self.rootViewController.view.addSubview(fillerView)
//
//        self.rootViewController.view.bringSubviewToFront(self.rootViewController.tabBar)
//        
//    }
//
//}
//
//class MyCustomDelegate: TabBarAnimationDelegate{
//    
//    override func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController.viewController.tabBarItem.tag == 5{
//            viewController.viewController.tabBarItem.image = #imageLiteral(resourceName: "Group 396")
//            openSideMenu.accept(true)
//            return false
//        }
//        return true
//    }
//    
////    override func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
////        if viewController.viewController .tabBarItem.tag == 5{
////            print("SELEKT ", viewController)
////            return false
////        }
////    }
//}
//
//extension UIImage {
//    convenience init(view: UIView) {
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.render(in:UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.init(cgImage: image!.cgImage!)
//    }
//}
