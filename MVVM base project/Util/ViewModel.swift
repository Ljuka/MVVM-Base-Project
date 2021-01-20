//
//  ViewModel.swift
//  xCoordinatorsTest
//
//  Created by Ljubo Maricevic on 18/02/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire

open class ViewModel {
    
    static let shared = ViewModel()
    
    static func handleError<T>(errorData: MoyaError) -> ApiResource<T>{
        if !NetworkReachabilityManager()!.isReachable{
            return ApiResource(status: .noInternetConnection, error: "check_internet")
        }
        switch errorData {
        case .underlying(_, let response):
            if response == nil {
                return ApiResource(status: .error, error: "E999")
            } else {
                let decoder = JSONDecoder()
                do {
                    let apiErrors = try decoder.decode(ApiError.self, from: response!.data)
                    return ApiResource(status: .error, error: (apiErrors.errorCode != nil ? apiErrors.errorCode : "E999")!)
                } catch _ {
                    return ApiResource(status: .error, error: "E999")
                }
            }
        default:
            return ApiResource(status: .error, error: "E999")
        }
    }

    func networkRequest<M:Codable>(provider: MoyaProvider<NetworkApi>, disposeBag: DisposeBag, networkApi: NetworkApi, model: M.Type, completion: ((ApiResource<M>) -> Void)? = nil){

        var provider = provider
        provider = MoyaProvider<NetworkApi>(plugins: [NetworkLoggerPlugin.init(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])
//        , AuthPlugin(token: AuthService.shared.token)
        
        provider.request(networkApi) { (result) in
            switch result {
            case .success(let response):
                do{
                    if response.data.count == 0{
                        completion!(ApiResource(status: .successNoData))
                        return
                    }
                    let object = try response.map(to: model.self)
                    completion!(ApiResource(status: .success, data: object))
                }
                catch{
                    completion!(ApiResource(status: .error, error: "E999"))
                }
            case .failure(let error):
                if error.response?.statusCode == 401{
                    AuthService.shared.refreshToken().asObservable().subscribe(onNext: { (result) in
                        if result{
                            self.networkRequest(provider: provider, disposeBag: disposeBag, networkApi: networkApi, model: model, completion: completion)
                        }
                        else{
                            completion?(ApiResource(status: .noToken))
                        }
                    }).disposed(by: disposeBag)
                }
                else{
                    completion!(ViewModel.handleError(errorData: error))
                }
            }
        }
    }
    
}
