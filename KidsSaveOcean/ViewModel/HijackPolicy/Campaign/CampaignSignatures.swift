//
//  CampaignSignatures.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct CampaignSignatures: Codable {

    enum CodingKeys: String, CodingKey {
        case campaignId = "campaign_id"
        case signaturesRequired = "signatures_required"
        case signaturesCollected = "signatures_collected"
    }

    var campaignId: String
    var signaturesRequired: Int
    var signaturesCollected: Int

}
