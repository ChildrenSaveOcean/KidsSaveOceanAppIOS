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
    var name: String
    var numberOfLetters: Int
    var action: Action?

    init(with name: String, _ location: CLLocationCoordinate2D, _ numberOfLetters: Int, _ action: Action?) {
        self.name = name
        self.coordinate = location
        self.numberOfLetters = numberOfLetters
        self.action = action
    }

    var title: String? {
        return self.name
    }

    var subtitle: String? {
        return "number of letters: \(self.numberOfLetters)"
    }

    func getNumberOfLetters() -> Int {
        return numberOfLetters
    }

}
