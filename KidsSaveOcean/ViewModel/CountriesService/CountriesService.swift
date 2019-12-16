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

    private static var sharedCountriesService: CountriesService = {
        let countriesService = CountriesService()

        return countriesService
    }()

    class func shared() -> CountriesService {
        return sharedCountriesService
    }

    func setup() {
        self.fetchContacts(databaseReferenece: Database.database().reference()) {
            self.contryContactsHasBeenLoaded = true
            NotificationCenter.default.post(name: .countriesHasBeenLoaded, object: nil)
            
        }
    }

    func fetchContacts(databaseReferenece: DatabaseReference, _ completion: (() -> Void)?) {

        countriesContacts.removeAll()

        databaseReferenece.child(childName).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                completion?()

                return
            }

            for country in snapshotValue {

                guard let value = country.value as? NSDictionary else {
                    continue
                }

                guard let code = country.key as? String else {
                    continue
                }

                guard let name = value["country_name"] as? String else {
                    continue
                }
                
                guard let address = value["country_address"] as? String else {
                    continue
                }

                var coordinates: CLLocationCoordinate2D?
                if let longitude = value["longitude"] as? Double,
                    let latitude = value["latitude"] as? Double {
                    coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }

                var countryContact = CountryContact(code: code, name: name, address: address, coordinates: coordinates)

                if let head = value["country_head_of_state_title"] as? String {
                    countryContact.head_of_state = head
                }

                if let lettersCount = value["letters_written_to_country"] as? Int {
                    countryContact.letters_written = lettersCount
                }
                
                if let number = value["country_number"] as? Int {
                    countryContact.number = number
                }
                
                self.countriesContacts.append(countryContact)
            }

            completion?()
        })
//        { (error) in
//            //completion?()
//            print(error.localizedDescription)
//        }
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
    
    private func getNearestCountryToUserLocation() -> CountryContact? { // TODO
        
        guard CLLocationManager.locationServicesEnabled() else { return nil }
        
        let locationService = LocationService.shared()
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

        let lettersCount = country.letters_written + 1

        var latitude: Double = 0
        var longitude: Double = 0
        if country.coordinates != nil {
            latitude = country.coordinates!.latitude  //String(format: "%f", country.coordinates!.latitude)
            longitude = country.coordinates!.longitude //String(format: "%f", country.coordinates!.longitude)
        }

        Database.database().reference().child(childName)
            .child(country.code).setValue(["country_number": country.number ?? 0,
                                           "country_name": country.name,
                                           "letters_written_to_country": lettersCount,
                                           "country_head_of_state_title": country.head_of_state as Any,
                                           "country_address": country.address as Any,
                                           "latitude": latitude,
                                           "longitude": longitude ]) { (error: Error?, _: DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).") // TODO app should not crash if there is some problem with database
            } else {
                print("Data saved successfully!")
            }
        }

        setup()
    }
}
