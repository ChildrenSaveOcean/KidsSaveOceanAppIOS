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
    static var databaseReferenece: DatabaseReference = Database.database().reference().child(nodeName)
    var hijackPolicies = [HijackPolicy]()
    
    static var shared = HijackPoliciesViewModel()

    var policiesHaveBeenLoaded = false {
        didSet {
            if policiesHaveBeenLoaded {
                NotificationCenter.default.post(name: .policiesHaveBeenLoaded, object: nil)
            }
        }
    }

    static func fetchPolicies(_ completion: (() -> Void)? = nil) {

        shared.hijackPolicies.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            shared.hijackPolicies = snapshotValue.compactMap({ (id, dictionary) in

                guard let id = id as? String,
                      let dictionary = dictionary as? Dictionary<String, Any> else {
                    return nil
                }

                var policy = HijackPolicy(with: dictionary)
                policy?.id = id
                return policy
            })

            shared.policiesHaveBeenLoaded = true
            completion?()

        })
    }
    
    func updateVotes(policy: HijackPolicy, value: Int) {
        HijackPoliciesViewModel.databaseReferenece.child(policy.id).child("votes").setValue(value)
    }

    func getPolicyAttrString(for policy: String) -> NSMutableAttributedString {
        let attrPolicyStr = NSMutableAttributedString(string: "Policy chosen: ")
        let font = UIFont.proRegular15
        attrPolicyStr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrPolicyStr.length))
        
        //let policyDescr = policy.description
        let attrPolicyDescrStr = NSMutableAttributedString(string: policy)
        let boldFont = UIFont.proSemiBold15
        attrPolicyDescrStr.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 0, length: attrPolicyDescrStr.length))

        let resultPolicyStr = NSMutableAttributedString()
        resultPolicyStr.append(attrPolicyStr)
        resultPolicyStr.append(attrPolicyDescrStr)
        return resultPolicyStr
    }
}
