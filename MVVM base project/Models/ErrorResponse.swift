//
//  ErrorResponse.swift
//  xCoordinatorsTest
//
//  Created by Ljubo Maricevic on 18/02/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation

struct ApiErrorResponse: Codable {
    let errors: [String: [String]]!
    
    private enum CodingKeys: String, CodingKey {
        case errors
    }
}

struct ApiError: Codable {
    let errorCode: String?
    let errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case errorCode = "error-code"
        case errorMessage = "error-message"
    }
}


struct RegisterParams: Codable{
    let fullName: String?
    let email: String
    let phoneNumber: String
    let password: String
    let rePassword: String
}
