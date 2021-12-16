//
//  Campaign.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct Campaign: Codable {

    enum CodingKeys: String, CodingKey {
        case hijack_policy, live, location_id, signatures_collected, signatures_required
    }

    var id: String = ""

    let hijack_policy: String
    let live: Bool
    let location_id: String
    var signatures_collected: Int
    let signatures_required: Int
    
    mutating func updateSignagureCollected(to value: Int) {
        self.signatures_collected = value
    }
}
