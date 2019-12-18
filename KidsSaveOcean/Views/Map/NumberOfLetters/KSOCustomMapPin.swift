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
            guard let annotation = newValue as? KSOPinOfLetters else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            glyphText = String(annotation.getNumberOfLetters() )
            
            guard let action = annotation.action else {
                rightCalloutAccessoryView = UIButton(type: .roundedRect)
                return
                
            }
            
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let subtitleText = annotation.subtitle! + "\n" + action.action_description
            let subtitleLabel = UILabel()
            subtitleLabel.font = UIFont.proRegular11
            subtitleLabel.textColor = .gray
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

            subtitleLabel.text = subtitleText
            subtitleLabel.numberOfLines = 0
            detailCalloutAccessoryView = subtitleLabel
        }
    }
}
