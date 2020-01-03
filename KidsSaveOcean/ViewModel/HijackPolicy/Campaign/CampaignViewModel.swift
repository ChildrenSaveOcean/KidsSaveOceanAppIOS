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
    var databaseReferenece: DatabaseReference = Database.database().reference().child(nodeName)
    var campaigns = [Campaign]()
    
    private static var sharedCampaignsViewModel: CampaignViewModel = {
        let viewModel = CampaignViewModel()
        return viewModel
    }()

    class func shared() -> CampaignViewModel {
        return sharedCampaignsViewModel
    }
    
    func setup() {
        fetchCampaigns(nil)
    }
    
    // swiftlint:disable cyclomatic_complexity
    func fetchCampaigns(_ completion: (() -> Void)?) {

        campaigns.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            for campaign in snapshotValue {

                guard let id = campaign.key as? String else {
                    continue
                }
                
                guard let value = campaign.value as? NSDictionary else {
                    continue
                }

                guard let policy = value["hijack_policy"] as? String else {
                    continue
                }
                guard let live = value["live"] as? Bool else {
                    continue
                }
                guard let location = value["location_id"] as? String else {
                    continue
                }
                guard let sign_collected = value["signatures_collected"] as? Int else {
                    continue
                }

                guard let sigh_required = value["signatures_required"] as? Int else {
                    continue
                }
                
                let campaignObj = Campaign(id: id, hijack_policy: policy, live: live, location_id: location, signatures_collected: sign_collected, signatures_required: sigh_required)
                
                self.campaigns.append(campaignObj)
            }
    
            if completion != nil {
                completion!()
            }
        })
    }
    
//    func updatePlannedSignatures(campaign: Campaign, value: Int) {
//        Database.database().reference().child(CampaignViewModel.nodeName).child(campaign.id).child("signatures_pledged").setValue(value)
//            setup()
//    }
//
//    func updateCollectedSignatures(campaign: Campaign, value: Int) {
//        Database.database().reference().child(CampaignViewModel.nodeName).child(campaign.id).child("signatures_collected").setValue(value)
//            setup()
//   }
}
