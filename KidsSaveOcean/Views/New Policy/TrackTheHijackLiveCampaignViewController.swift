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
        
        let userCampaign = UserViewModel.shared().campaign
        let campaign1 = CampaignViewModel.shared().campaigns.filter { $0.id == userCampaign?.campaign_id }.first
        guard let campaign = campaign1, UserViewModel.shared().isUserLocationCampaignIsLive()
            else { return }
        
        let policy = HijackPoliciesViewModel.shared().hidjackPolicies.filter {$0.id == campaign.hijack_policy}.first
        if policy != nil {
            policyChosenLabel.attributedText = HijackPoliciesViewModel.shared().getPolicyAttrString(for: policy!)
        }
        
        let location = HijackPLocationViewModel.shared().hidjackPLocations.filter { $0.id == campaign.location_id }.first?.location ?? ""
        campaignLocation.text = "Campaign location: " + location
        
        signatureRequiredLabel.text = "Signatures required: " + String( campaign.signatures_required)
        totalCollectedSignaturesLabel.text = "Total collected so far: " + String(campaign.signatures_collected)
        deadlineLabel.text = "--"
        
        userPlannedSignatures.text = "Your planned signatures: " + String( UserViewModel.shared().signatures_pledged)
        userCollectedSignatures.text = "Your collected signatures: " + String(userCampaign?.signatures_collected ?? 0)
        
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
