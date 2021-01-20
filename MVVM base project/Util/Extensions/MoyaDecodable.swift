//
//  MoyaDecodable.swift
//  BaseProject
//
//  Created by User on 05/03/2019.
//  Copyright © 2019 NV. All rights reserved.
//

import Foundation
import Moya

extension Moya.Response {
    
    public func map<T>(to type: T.Type, using decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Swift.Decodable {
        let decoder = decoder
        return try decoder.decode(type, from: data)
    }
    
}
//
//extension MoyaProvider {
//    convenience init(handleRefreshToken: Bool) {
//        if handleRefreshToken {
//            self.init(requestClosure: MoyaProvider.endpointResolver())
//        } else {
//            self.init()
//        }
//    }
//
//    static func endpointResolver() -> MoyaProvider<Target>.RequestClosure {
//        return { (endpoint, closure) in
//            //Getting the original request
//            let request = try! endpoint.urlRequest()
//
//            //assume you have saved the existing token somewhere
//            if (#tokenIsNotExpired#) {
//                // Token is valid, so just resume the original request
//                closure(.success(request))
//                return
//            }
//
//            //Do a request to refresh the authtoken based on refreshToken
//            authenticationProvider.request(.refreshToken(params)) { result in
//                switch result {
//                case .success(let response):
//                    let token = response.mapJSON()["token"]
//                    let newRefreshToken = response.mapJSON()["refreshToken"]
//                    //overwrite your old token with the new token
//                    //overwrite your old refreshToken with the new refresh token
//
//                    closure(.success(request)) // This line will "resume" the actual request, and then you can use AccessTokenPlugin to set the Authentication header
//                case .failure(let error):
//                    closure(.failure(error)) //something went terrible wrong! Request will not be performed
//                }
//            }
//    }
//}
