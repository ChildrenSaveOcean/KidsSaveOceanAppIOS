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
    var hidjackPLocations = [HijackLocation]()
    
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

        hidjackPLocations.removeAll()
        
        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            for location in snapshotValue {

                guard let id = location.key as? String else {
                    continue
                }
                
                guard let value = location.value as? NSDictionary else {
                    continue
                }

                guard let location = value["location"] as? String else {
                    continue
                }
                
                let policyLocation = HijackLocation(id: id, location: location)
                self.hidjackPLocations.append(policyLocation)
            }
    
            if completion != nil {
                completion!()
            }
        })
    }
}
