//
//  Letter.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 2/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import MapKit

struct Letter {
    var country: String
    var coordinates: CLLocationCoordinate2D?
    
    init(country: String, coordinates: CLLocationCoordinate2D?) {
        self.country = country
        self.coordinates = coordinates
    }
}
