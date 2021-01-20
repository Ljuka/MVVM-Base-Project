//
//  BundleExtensions.swift
//  GoPlant.me
//
//  Created by Ljubo Maricevic on 18/02/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }

}
