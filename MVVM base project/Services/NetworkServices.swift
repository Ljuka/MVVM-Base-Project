//
//  Moya.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 11/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import Moya
import Localize_Swift


enum NetworkApi{
    case register(fullName: String, email: String, phoneNumber: String, password: String, rePassword: String)
    case refreshToken
}

extension NetworkApi: TargetType{
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: BASE_URL)!
        }
    }
    
    var path: String {
        switch self {
        case .register(_,_,_,_,_):
            return "register.php"
        default:
            return ""
        }
    }
    
    var validationType: ValidationType {
        switch self {
        default:
            return .successCodes
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .register(let fullName, let email, let phoneNumber, let password, let rePassword):
            return .requestParameters(parameters: ["fullName": fullName, "email": email, "phoneNumber": phoneNumber, "password": password, "rePassword": rePassword], encoding: URLEncoding.httpBody)
        
//  DEFAULT PLAIN
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            if AuthService.shared.token == ""{
                return nil
            }
            else{
                return .some(["Authorization": "Bearer \(AuthService.shared.token)"])
            }
        }
    }
}

enum ApiStatus {
    case none
    case loading
    case success
    case successNoData
    case error
    case noInternetConnection
    case noToken
}
