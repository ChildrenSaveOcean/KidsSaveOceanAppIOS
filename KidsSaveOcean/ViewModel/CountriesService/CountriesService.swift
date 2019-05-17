//
//  CountriesService.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 2/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class CountriesService {

    var countriesContacts = [CountryContact]()

    private static var sharedCountriesService: CountriesService = {
        let countriesService = CountriesService()

        return countriesService
    }()

    class func shared() -> CountriesService {
        return sharedCountriesService
    }

    func setup() {
        self.fetchContacts(databaseReferenece: Database.database().reference()) {
            NotificationCenter.default.post(name: Notification.Name(Settings.CountriesHasBeenLoadedNotificationName), object: nil)
        }
    }

    func fetchContacts(databaseReferenece: DatabaseReference, _ completion: (() -> Void)?) {
        countriesContacts.removeAll()

        databaseReferenece.child("COUNTRIES").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                completion?()

                return
            }

            for country in snapshotValue {
                
                guard let value = country.value as? NSDictionary else {
                    continue
                }

                guard let name = country.key as? String else {
                    continue
                }
                
                guard let address = value["country_address"] as? String else {
                    continue
                }

                var coordinates: CLLocationCoordinate2D? = nil
                if let longitudeString = value["longitude"] as? String,
                    let latitudeString = value["latitude"] as? String,
                    let longitude = Double(longitudeString),
                    let latitude = Double(latitudeString) {
                    coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }

                var countryContact = CountryContact(name: name, code: nil, address: address, coordinates:coordinates)
                
                if let head = value["country_head_of_state_title"] as? String {
                    countryContact.head_of_state = head
                }
                
                if let lettersCount = value["letters_written_to_country"] as? Int {
                    countryContact.letters_written = lettersCount
                }
                
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
