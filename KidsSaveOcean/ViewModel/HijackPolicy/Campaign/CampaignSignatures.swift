//
//  CampaignSignatures.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct CampaignSignatures {
    var campaign_id: String
    var signatures_required: Int
    var signatures_collected: Int
    
    var idKey = "campaign_id"
    var requiredKey = "signatures_required"
    var collectedKey = "signatures_collected"
    
    init(campaign_id: String, signatures_required: Int, signatures_collected: Int) {
        self.campaign_id = campaign_id
        self.signatures_required = signatures_required
        self.signatures_collected = signatures_collected
    }
    
    init(campaing: [String: Any]) {
        self.campaign_id = campaing[idKey] as? String ?? ""
        self.signatures_required = campaing[requiredKey] as? Int ?? 0
        self.signatures_collected = campaing[collectedKey] as? Int ?? 0
    }
    
    func dictionary() -> [String: Any] {
        return [idKey: self.campaign_id,
                collectedKey: self.signatures_collected]
    }
}
