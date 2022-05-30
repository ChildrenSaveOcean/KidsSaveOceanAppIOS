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
    
    var databaseReferenece: DatabaseReference = Database.database().reference().child("HIJACK_POLICY_LOCATIONS")
    var hijackPLocations = [HijackLocation]()
    
    private static var sharedHijackPLocationViewModel: HijackPLocationViewModel = {
        let viewModel = HijackPLocationViewModel()
        return viewModel
    }()

    class func shared() -> HijackPLocationViewModel {
        return sharedHijackPLocationViewModel
    }
    
    func setup() {
        fetchPolicyLocations(nil)
    }
    
    func fetchPolicyLocations(_ completion: (() -> Void)?) {

        hijackPLocations.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            self.hijackPLocations = snapshotValue.compactMap({ (id, dictionary) in

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
