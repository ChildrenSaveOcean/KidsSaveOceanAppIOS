//
//  LettersService.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 2/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class LettersService {

    var letters = [Letter]()
    var mapPins = [KSOPinOfLetters]()

    private static var sharedLettersService: LettersService = {
        let lettersService = LettersService()

        return lettersService
    }()

    class func shared() -> LettersService {
        return sharedLettersService
    }

    func setup() {
        //self.fetchLetters(databaseReferenece: Database.database().reference(), nil)
        self.fetchLetters(databaseReferenece: Database.database().reference()) {
            NotificationCenter.default.post(name: Notification.Name(Settings.LettersHasBeenLoadedNotificationName), object: nil)
        }
    }

    func fetchLetters(databaseReferenece: DatabaseReference, _ completion: (() -> Void)?) {
        databaseReferenece.child("Letters").observeSingleEvent(of: .value, with: { [weak self] (snapshot) in

            self?.letters.removeAll()

            for letter in (snapshot.value as? NSDictionary)! {
                var letterInfos = [String: String]()

                for letterInfo in (letter.value as? NSDictionary)! {
                    switch letterInfo.key as? String {
                    case "longitude":
                        letterInfos["longitude"] = letterInfo.value as? String
                    case "latitude":
                        letterInfos["latitude"] = letterInfo.value as? String
                    case "country":
                        letterInfos["country"] = letterInfo.value as? String
                    default:
                        break
                    }
                }

                guard let country = letterInfos["country"] else {
                    continue
                }

                guard let longitudeString = letterInfos["longitude"], let latitudeString = letterInfos["latitude"] else {
                    self?.letters.append(Letter(country: country, coordinates: nil))
                    continue
                }

                guard let longitude = Double(longitudeString), let latitude = Double(latitudeString) else {
                    self?.letters.append(Letter(country: country, coordinates: nil))
                    continue
                }

                self?.letters.append(Letter(country: country, coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
            }

            self?.sortLetters()
            completion?()
        })
    }

    private func sortLetters() {
        let countries = letters.map { (letter) -> String in
            letter.country
        }.unique

        mapPins.removeAll()

        for country in countries {
            let countryLetters = letters.filter { (letter) -> Bool in
                letter.country == country
            }

            guard let contact = CountriesService.shared().contact(of: country), let coordinates = contact.coordinates else {
                continue
            }

            let pin = KSOPinOfLetters(with: country, coordinates, countryLetters.count)
            mapPins.append(pin)
        }

        mapPins = mapPins.sorted { (first: KSOPinOfLetters, second: KSOPinOfLetters) -> Bool in
            first.numberOfLetters > second.numberOfLetters
        }
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
