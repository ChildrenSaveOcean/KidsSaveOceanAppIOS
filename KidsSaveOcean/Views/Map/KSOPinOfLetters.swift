//
//  KSOPinOfLetters.swift
//  mapTest
//
//  Created by Renata on 07/07/2018.
//  Copyright © 2018 Renata. All rights reserved.
//

import UIKit
import MapKit

class KSOPinOfLetters: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    private var name : String
    private var numberOfLetters : Int
    
    init(with name: String, _ location: CLLocationCoordinate2D, _ numberOfLetters : Int) {
        self.name = name
        self.coordinate = location
        self.numberOfLetters = numberOfLetters
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return "number of letters: \(self.numberOfLetters)"
    }
    
}
