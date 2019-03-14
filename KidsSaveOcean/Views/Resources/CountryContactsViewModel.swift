//
//  CountryContactsViewModel.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase
import MapKit

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
                countries.append(CountryContact(name: name, code: code, address: nil, coordinates: nil))
            }
        }
        
        allCountries = countries
    }
    
    func fetchContacts(from service: CountriesService = CountriesService.shared(), _ completion: (() -> ())?) {
        if service.countriesContacts.count > 0 {
            countriesContacts = service.countriesContacts
            completion?()
            
            return
        }
        
        service.fetchContacts(databaseReferenece: databaseReferenece, { [weak self] in
            self?.countriesContacts = service.countriesContacts
            completion?()
        })
    }

    func contact(of country: String) -> CountryContact? {
        return countriesContacts.filter {
            $0.name == country
            }.first
    }
}
