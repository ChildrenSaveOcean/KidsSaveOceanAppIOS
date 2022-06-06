//
//  CampaignViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase

class CampaignViewModel {

    static var nodeName = "CAMPAIGNS"
    static var databaseReferenece: DatabaseReference = Database.database().reference().child(nodeName)
    var campaigns = [Campaign]()

    static var shared = CampaignViewModel()
    
    static func fetchCampaigns(_ completion: (() -> Void)? = nil) {

        shared.campaigns.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let snapshotValue = snapshot.value as? NSDictionary else {
                completion?()

                return
            }

            shared.campaigns = snapshotValue.compactMap({ (id, dictionary) in

                guard let id = id as? String,
                      let dictionary = dictionary as? Dictionary<String, Any> else {
                    return nil
                }

                var campaign = Campaign(with: dictionary)
                campaign?.id = id
                return campaign
            })

            completion?()

        })
    }

    func updateCollectedSignatures(campaign: Campaign, value: Int) {

        let newCollectedSignaturesNumber = (self.campaigns.filter{$0.id == campaign.id}.first?.signaturesCollected ?? 0) + value
        CampaignViewModel.databaseReferenece.child(campaign.id).child("signatures_collected").setValue(newCollectedSignaturesNumber)
   }
}
