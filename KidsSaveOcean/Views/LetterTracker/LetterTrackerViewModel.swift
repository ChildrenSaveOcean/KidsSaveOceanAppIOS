//
//  LetterTrackerViewModel.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 12/8/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import MapKit

final class LetterTrackerViewModel: NSObject {
    
    var allCountries: [CountryContact]?
    
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
}
