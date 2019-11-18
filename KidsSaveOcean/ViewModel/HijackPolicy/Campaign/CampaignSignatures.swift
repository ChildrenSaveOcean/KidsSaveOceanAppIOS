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
    var signatures_pledged: Int
    var signatures_collected: Int
    
    var idKey = "campaign_id"
    var pledgedKey = "signatures_pledged"
    var collectedKey = "signatures_collected"
    
    init(campaign_id: String, signatures_pledged: Int, signatures_collected: Int) {
        self.campaign_id = campaign_id
        self.signatures_pledged = signatures_pledged
        self.signatures_collected = signatures_collected
    }
    
    init(campaing: [String: Any]) {
        self.campaign_id = campaing[idKey] as? String ?? ""
        self.signatures_pledged = campaing[pledgedKey] as? Int ?? 0
        self.signatures_collected = campaing[collectedKey] as? Int ?? 0
    }
    
    func dictionary() -> [String: Any] {
        return [idKey: self.campaign_id,
                collectedKey: self.signatures_collected,
                pledgedKey: self.signatures_pledged]
    }
}
