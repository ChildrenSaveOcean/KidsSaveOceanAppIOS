//
//  HijackLocation.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct HijackLocation: Codable {

    enum CodingKeys: String, CodingKey {
        case location
    }

    var id: String = ""
    let location: String

}
