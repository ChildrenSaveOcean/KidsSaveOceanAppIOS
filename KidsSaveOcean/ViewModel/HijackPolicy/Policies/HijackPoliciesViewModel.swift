//
//  HijackPolicyViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase

class HijackPoliciesViewModel {
    
    static var nodeName = "HIJACK_POLICIES"
    var databaseReferenece: DatabaseReference = Database.database().reference().child(nodeName)
    var hidjackPolicies = [HijackPolicy]()
    
    private static var sharedHijackPolicyViewModel: HijackPoliciesViewModel = {
        let viewModel = HijackPoliciesViewModel()
        return viewModel
    }()

    class func shared() -> HijackPoliciesViewModel {
        return sharedHijackPolicyViewModel
    }
    
    func setup() {
        fetchPolicies(nil)
    }
    
    var policiesHaveBeenLoaded = false {
        didSet {
            if policiesHaveBeenLoaded {
                NotificationCenter.default.post(name: .policiesHaveBeenLoaded, object: nil)
            }
        }
    }
    
    func fetchPolicies(_ completion: (() -> Void)?) {

        hidjackPolicies.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            for policies in snapshotValue {

                guard let id = policies.key as? String else {
                    continue
                }
                
                guard let value = policies.value as? NSDictionary else {
                    continue
                }

                guard let description = value["description"] as? String else {
                    continue
                }
                
                guard let summary = value["summary"] as? String else {
                    continue
                }
                
                guard let votes = value["votes"] as? Int else {
                    continue
                }
                
                let policy = HijackPolicy(id: id, description: description, summary: summary, votes: votes)
                self.hidjackPolicies.append(policy)
            }
    
            self.policiesHaveBeenLoaded = true
            if completion != nil {
                completion!()
            }
        })
    }
    
    func updateVotes(policy: HijackPolicy, value: Int) {
         Database.database().reference().child(HijackPoliciesViewModel.nodeName).child(policy.id).child("votes").setValue(value)
             setup()
    }
    
    func getPolicyAttrString(for policy: HijackPolicy) -> NSMutableAttributedString {
        let attrPolicyStr = NSMutableAttributedString(string: "Policy chosen: ")
        let font = UIFont.proRegular15
        attrPolicyStr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrPolicyStr.length))
        
        let policyDescr = policy.description
        let attrPolicyDescrStr = NSMutableAttributedString(string: policyDescr)
        let boldFont = UIFont.proSemiBold15
        attrPolicyDescrStr.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 0, length: attrPolicyDescrStr.length))

        let resultPolicyStr = NSMutableAttributedString()
        resultPolicyStr.append(attrPolicyStr)
        resultPolicyStr.append(attrPolicyDescrStr)
        return resultPolicyStr
    }
}
