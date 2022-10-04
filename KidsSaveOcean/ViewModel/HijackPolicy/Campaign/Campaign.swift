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
        case hijackPolicy = "hijack_policy"
        case signaturesCollected = "signatures_collected"
        case signaturesRequired = "signatures_required"
        case locationId = "location_id"
        case live
    }

    var id: String = ""

    let hijackPolicy: String
    let live: Bool
    let locationId: String
    var signaturesCollected: Int
    let signaturesRequired: Int
    
    mutating func updateSignagureCollected(to value: Int) {
        self.signaturesCollected = value
    }
}
