//
//  UserCampaign.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/16/22.
//  Copyright © 2022 KidsSaveOcean. All rights reserved.
//

import Foundation

struct UserCampaign: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "campaign_id"
        case signaturesCollected = "signatures_collected"
    }

    var id: String
    var signaturesCollected: Int
}
