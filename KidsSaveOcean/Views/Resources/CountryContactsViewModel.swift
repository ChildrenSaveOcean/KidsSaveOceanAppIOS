//
//  CountryContactsViewModel.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase
import CountryPickerView

final class CountryContactsViewModel: NSObject {
    
    private let databaseReferenece: DatabaseReference
    private(set) var countriesContacts = [CountryContact]()
    
    init(databaseReferenece: DatabaseReference) {
        self.databaseReferenece = databaseReferenece
    }
    
    func fetchContacts(_ completion: (() -> ())?) {
        countriesContacts.removeAll()
        
        databaseReferenece.child("Countries").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                completion?()
                
                return
            }
            
            for country in snapshotValue {
                guard let value = country.value as? NSDictionary else {
                    continue
                }
                
                guard let name = value["name"] as? String else {
                    continue
                }
                
                guard let code = value["code"] as? String else {
                    continue
                }
                
                guard let address = value["address"] as? String else {
                    continue
                }
                
                let countryContact = CountryContact(name: name, code: code, address: address)
                self.countriesContacts.append(countryContact)
            }
            completion?()
        }) { (error) in
            completion?()
            print(error.localizedDescription)
        }
    }
    
    func contact(of country: Country) -> CountryContact? {
        return countriesContacts.filter {
            $0.code == country.code
            }.first
    }
}
