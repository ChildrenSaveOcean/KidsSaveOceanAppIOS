//
//  ActionViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 12/15/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ActionViewModel {
    
    var actions = [Action]()
    
    private static var sharedActionViewModel: ActionViewModel = {
        let viewModel = ActionViewModel()
        return viewModel
    }()

    class func shared() -> ActionViewModel {
        return sharedActionViewModel
    }
    
    func setup(_ completion: (() -> Void)?) {
        self.fetchActions(databaseReferenece: Database.database().reference()) {
            completion?()
        }
    }
    
    private func fetchActions(databaseReferenece: DatabaseReference, _ completion: (() -> Void)?) {
        actions.removeAll()
        
        databaseReferenece.child("ACTIONS").observeSingleEvent(of: .value) { (snapshot) in

            guard let snapshotValue = snapshot.value as? NSDictionary else {
                 completion?()

                 return
             }
             
             for action in snapshotValue {

                 guard let value = action.value as? NSDictionary else {
                     continue
                 }

                 guard let description = value["action_description"] as? String else {
                     continue
                 }
                
                guard let link = value["action_link"] as? String else {
                    continue
                }
                
                guard let location = value["action_location"] as? String else {
                    continue
                }

                let action = Action(action_description: description, action_link: link, action_location: location)
                self.actions.append(action)
            }
            
            completion?()
        }
        
    }
    
}
