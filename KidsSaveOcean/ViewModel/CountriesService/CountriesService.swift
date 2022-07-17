//
//  CountriesService.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 2/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MapKit

class CountriesService: NSObject {
    
    let childName = "COUNTRIES"
    var countriesContacts = [CountryContact]()
    var contryContactsHasBeenLoaded = false

    static var shared = CountriesService()

    func setup() {

        self.fetchContacts(databaseReferenece: Database.database().reference()) {

            ActionViewModel.shared.setup { () in
    
                let actions = ActionViewModel.shared.actions

                for action in actions {
                    self.countriesContacts.filter { $0.code == action.action_location }.first?.action = action
                }

                self.contryContactsHasBeenLoaded = true
                NotificationCenter.default.post(name: .countriesHasBeenLoaded, object: nil)
            }
        }
    }

    func fetchContacts(databaseReferenece: DatabaseReference, _ completion: (() -> Void)?) {

        countriesContacts.removeAll()

        databaseReferenece.child(childName).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let snapshotValue = snapshot.value as? NSDictionary else {
                completion?()

                return
            }

            self.countriesContacts = snapshotValue.compactMap({ (code, dictionary) in

                guard let code = code as? String,
                      let dictionary = dictionary as? Dictionary<String, Any> else {
                    return nil
                }

                let countryContact = CountryContact(with: dictionary)
                countryContact?.code = code
                return countryContact
            })

            completion?()
        })

    }

    func contact(of countryCode: String) -> CountryContact? {
        return countriesContacts.filter { $0.code == countryCode }.first
    }

    func getUserCountry() -> CountryContact? {
        return getNearestCountryToUserLocation() ?? getUserLocaleCountry()
    }
    
    private func getUserLocaleCountry() -> CountryContact? {
        return  countriesContacts.filter({$0.code == NSLocale.current.regionCode}).first
    }
    
    private func getNearestCountryToUserLocation() -> CountryContact? {
        
        guard CLLocationManager.locationServicesEnabled() else { return nil }
        
        let locationService = LocationService.shared
        guard locationService.authorizationStatus else { return nil }
        guard let userLocation = locationService.locationManager.location else { return nil }
        
        let userCoordinates = MKMapPoint(userLocation.coordinate)
        let nearest = countriesContacts.min(by: { (first, second) -> Bool in
            let capitalCountry1 = MKMapPoint(first.coordinates!)
            let capitalCountry2 = MKMapPoint(second.coordinates!)
            return capitalCountry1.distance(to: userCoordinates) < capitalCountry2.distance(to: userCoordinates)
        })
        
        return nearest
    }
    
    func increaseLettersWrittenForCountry(_ country: CountryContact) {

        country.letters_written += 1

        Database.database().reference().child(childName)
            .child(country.code).setValue( country.dictionaryRepresentation ) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        setup()
    }
}
