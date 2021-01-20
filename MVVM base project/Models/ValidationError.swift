//
//  ValidationError.swift
//  onepower-ios
//
//  Created by Ljubo Maricevic on 25/07/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import Validator

struct ErrorValidation: ValidationError {
    
    let message: String
    
    public init(_ message: String) {
        
        self.message = message
    }
}
