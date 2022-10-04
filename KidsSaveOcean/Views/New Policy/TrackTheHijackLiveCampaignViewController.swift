//
//  TrackTheHijackLiveCampaignViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 12/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class TrackTheHijackLiveCampaignViewController: UIViewController, Instantiatable {
    
    @IBOutlet weak var policyChosenLabel: UILabel!
    @IBOutlet weak var campaignLocation: UILabel!
    @IBOutlet weak var signatureRequiredLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var totalCollectedSignaturesLabel: UILabel!
    @IBOutlet weak var userPlannedSignatures: UILabel!
    @IBOutlet weak var userCollectedSignatures: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userCampaign = User.shared.campaign
        let campaign = CampaignViewModel.shared.campaigns.filter { $0.id == userCampaign?.id }.first
        guard let userCampaign = userCampaign,
              let campaign = campaign, User.shared.isUserLocationCampaignIsLive()
            else { return }

        if let policy = HijackPoliciesViewModel.shared.hijackPolicies.filter ({$0.id == campaign.hijackPolicy}).first {
            policyChosenLabel.attributedText = HijackPoliciesViewModel.shared.getPolicyAttrString(for: policy.description)
        }

        let location = HijackPLocationViewModel.shared.hijackPLocations.filter { $0.id == campaign.locationId }.first?.location ?? ""
        campaignLocation.text = "Campaign location: " + location
        
        signatureRequiredLabel.text = "Signatures required: " + String( campaign.signaturesRequired)
        totalCollectedSignaturesLabel.text = "Total collected so far: " + String(campaign.signaturesCollected)
        deadlineLabel.text = "--"
        
        userPlannedSignatures.text = "Your planned signatures: " + String( User.shared.signaturesPledged)
        userCollectedSignatures.text = "Your collected signatures: " + String(userCampaign.signaturesCollected)
        
    }
    
    @IBAction func spreadAction(_ sender: Any) {
        ShareKidsSaveOcean.share(target: self)
    }
    
    @IBAction func updateAction(_ sender: Any) {
        let signUpViewController = SignUpUpdateViewController.instantiate()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @IBAction func moreInfoAction(_ sender: Any) {
    }
    
}
