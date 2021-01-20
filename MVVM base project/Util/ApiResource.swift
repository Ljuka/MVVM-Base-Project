//
//  ApiResult.swift
//  xCoordinatorsTest
//
//  Created by Ljubo Maricevic on 18/02/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation


struct ApiResource<T> {
    var status: ApiStatus = .none
    var error: String = ""
    var data: T! = nil
    
    init(status: ApiStatus, error: String){
        self.status = status
        self.error = error
    }
    
    init(status: ApiStatus) {
        self.status = status
        self.error = ""
    }
    
    init(status: ApiStatus, data: T) {
        self.status = status
        self.error = ""
        self.data = data
    }
    
    init(data: T){
        self.status = .none
        self.error = ""
        self.data = data
    }
    
    init() {
        self.status = .none
        self.error = ""
    }

}


