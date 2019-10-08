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
    
            if completion != nil {
                completion!()
            }
        })
    }
    
    func updateVotes(policy: HijackPolicy, value: Int) {
         Database.database().reference().child(HijackPoliciesViewModel.nodeName).child(policy.id).child("votes").setValue(value)
             setup()
    }
}
