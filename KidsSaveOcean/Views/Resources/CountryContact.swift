//
//  CountryContactDetails.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/9/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

struct CountryContact {
    let name: String
    let code: String
    let address: String?
    
    init(name: String, code: String, address: String?) {
        self.name = name
        self.code = code
        self.address = address
    }
}
