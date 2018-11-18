//
//  CountryContactsViewModel.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

final class CountryContactsViewModel: NSObject {
    
    private let databaseReferenece: DatabaseReference
    private(set) var countriesContacts = [CountryContact]()
    var allCountries: [CountryContact]?
    
    init(databaseReferenece: DatabaseReference) {
        self.databaseReferenece = databaseReferenece
    }
    
    func fetchCountries() {
        if let allCountries = allCountries, allCountries.count > 0 {
            return
        }
        
        var countries = [CountryContact]()
        for code in Locale.isoRegionCodes as [String] {
            if let name = Locale.autoupdatingCurrent.localizedString(forRegionCode: code) {
                countries.append(CountryContact(name: name, code: code, address: nil))
            }
        }
        
        allCountries = countries
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

    func contact(of country: String) -> CountryContact? {
        return countriesContacts.filter {
            $0.name == country
            }.first
    }
}
