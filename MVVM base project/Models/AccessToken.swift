//
//  AccessToken.swift
//  GoPlant.me
//
//  Created by Ljubo Maricevic on 02/03/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
  let token: String

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    return request
  }
    
}
//
//// MARK: - Token
//struct Token: Codable {
//    let accessToken, tokenType: String?
//    let expiresIn: Int?
//    let user: User?
//
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "access_token"
//        case tokenType = "token_type"
//        case expiresIn = "expires_in"
//        case user
//    }
//}
//
//struct RefreshToken: Codable{
//    let token: String?
//}
//
//
//// MARK: - User
//struct User: Codable {
//    let id: Int?
//    let fullName, phoneNumber, email: String?
//    let emailVerifiedAt: String?
//    let imagePath, quarantineLatitude, quarantineLongitude: String?
//    let languageID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fullName = "full_name"
//        case phoneNumber = "phone_number"
//        case email
//        case emailVerifiedAt = "email_verified_at"
//        case imagePath = "image_path"
//        case quarantineLatitude = "quarantine_latitude"
//        case quarantineLongitude = "quarantine_longitude"
//        case languageID = "language_id"
//    }
//}
