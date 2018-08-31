//
//  KSOCustomMapPin.swift
//  KidsSaveOcean
//
//  Created by Renata on 31/08/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import MapKit

class KSOCustomMapPin: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let ksoPin = newValue as? KSOPinOfLetters else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            glyphText = String(ksoPin.getNumberOfLetters() )
        }
    }
}
