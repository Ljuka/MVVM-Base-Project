//
//  User.swift
//  ZRKB
//
//  Created by Ljubo Maricevic on 29/09/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation
// MARK: - User
struct User: Codable {
    let email, fullName, phoneNumber, image: String?
}
