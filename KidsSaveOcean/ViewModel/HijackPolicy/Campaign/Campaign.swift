//
//  Campaign.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct Campaign {
    let id: String
    let hijack_policy: String
    let live: Bool
    let location_id: String
    var signatures_collected: Int
    let signatures_required: Int
    
    init(id: String, hijack_policy: String, live: Bool, location_id: String, signatures_collected: Int, signatures_required: Int) {
        self.id = id
        self.hijack_policy = hijack_policy
        self.live = live
        self.location_id = location_id
        self.signatures_collected = signatures_collected
        self.signatures_required = signatures_required
    }
    
    mutating func updateSignagureCollected(to value: Int) {
        self.signatures_collected = value
    }
}
