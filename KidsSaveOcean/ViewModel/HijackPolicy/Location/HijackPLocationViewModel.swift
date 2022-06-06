//
//  HijackPolicyLocationViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase

class HijackPLocationViewModel {
    
    static var databaseReferenece: DatabaseReference = Database.database().reference().child("HIJACK_POLICY_LOCATIONS")
    static var shared = HijackPLocationViewModel()

    var hijackPLocations = [HijackLocation]()

    static func fetchPolicyLocations(_ completion: (() -> Void)? = nil) {

        shared.hijackPLocations.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            shared.hijackPLocations = snapshotValue.compactMap({ (id, dictionary) in

                guard let id = id as? String,
                      let dictionary = dictionary as? Dictionary<String, Any> else {
                    return nil
                }

                var policyLocation = HijackLocation(with: dictionary)
                policyLocation?.id = id
                return policyLocation
            })

            completion?()
        })
    }
}
