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

            self.actions = (snapshot.value as? NSDictionary)?.allValues.compactMap{ Action(with: $0 as? Dictionary<String, Any> ) } ?? []
            
            completion?()
        }
        
    }
    
}
