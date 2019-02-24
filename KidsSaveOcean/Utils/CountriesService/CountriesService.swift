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
        self.fetchContacts(databaseReferenece: Database.database().reference(), nil)
    }
    
    func fetchContacts(databaseReferenece: DatabaseReference, _ completion: (() -> ())?) {
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
                
                guard let longitudeString = value["longitude"] as? String, let latitudeString = value["latitude"] as? String else {
                    continue
                }
                
                guard let longitude = Double(longitudeString), let latitude = Double(latitudeString) else {
                    continue
                }
                
                let countryContact = CountryContact(name: name, code: code, address: address, coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
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
