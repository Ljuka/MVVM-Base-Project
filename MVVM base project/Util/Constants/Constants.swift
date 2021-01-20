//
//  Constants.swift
//  Start Project
//
//  Created by Ljubo Maricevic on 03/10/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation

#if ENV_TEST
    let BASE_URL = "https://example.com/dev/api/"
#elseif ENV_STAGE
    let BASE_URL = "https://example.com/stage/api/"
#else
    let BASE_URL = "https://example.com/api/"
#endif

// For keychain
let EMAIL = "email"
let PASSWORD = "pass"
let TOKEN = "token"
let REFRESH = "refresh"

