//
//  CountryContactsViewModel.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import FirebaseDatabase
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
                countries.append(CountryContact(code: code, name: name, address: nil, coordinates: nil))
            }
        }

        allCountries = countries.sorted(by: { (country1, country2) -> Bool in
            country1.name < country2.name
        })
    }

    func fetchContacts(from service: CountriesService = CountriesService.shared, _ completion: (() -> Void)?) {

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

    func contact(of countryCode: String) -> CountryContact? {
        return countriesContacts.filter {
            $0.code == countryCode
            }.first
    }
}
