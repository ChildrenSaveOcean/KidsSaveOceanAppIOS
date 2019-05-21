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

    let childName = "COUNTRIES"
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

        databaseReferenece.child(childName).observeSingleEvent(of: .value, with: { (snapshot) in
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

                var coordinates: CLLocationCoordinate2D?
                if let longitude = value["longitude"] as? Double,
                    let latitude = value["latitude"] as? Double {
                    coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }

                var countryContact = CountryContact(name: name, code: nil, address: address, coordinates: coordinates)

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

    func getNearestCountryToUserLocation() -> CountryContact? {

        let countryLocale = NSLocale.current
        let countryCode = countryLocale.regionCode
        let countryName = (countryLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode!)

        let nearest = countriesContacts.filter({$0.name == countryName}).first
            //: CountryContact? = nil
        /*
         let locationManager = CLLocationManager()
         if CLLocationManager.locationServicesEnabled() {
            let userLocation = locationManager.location
            let coordinate = userLocation!.coordinate
            let userCoordinates = MKMapPoint(coordinate)
            nearest = countriesContacts.min(by: { (first, second) -> Bool in
                let capitalCountry1 = MKMapPoint(first.coordinates!)
                let capitalCountry2 = MKMapPoint(second.coordinates!)
                return capitalCountry1.distance(to: userCoordinates) < capitalCountry2.distance(to: userCoordinates)
            })
        }*/

        return nearest
    }

    func increaseLettersWrittenForCountry(_ country: CountryContact) {

        let lettersCount = country.letters_written + 1

        var latitude = ""
        var longitude = ""
        if country.coordinates != nil {
            latitude = String(format: "%f", country.coordinates!.latitude)
            longitude = String(format: "%f", country.coordinates!.longitude)
        }

        Database.database().reference().child(childName)
            .child(country.name).setValue(["letters_written_to_country": lettersCount,
                                           "country_head_of_state_title": country.head_of_state as Any,
                                           "country_address": country.address as Any,
                                           "latitude": latitude,
                                           "longitude": longitude ]) {
            (error: Error?, _: DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).") // TODO app should not crash if there is some problem with database
            } else {
                print("Data saved successfully!")
            }
        }

        setup()
    }
}
