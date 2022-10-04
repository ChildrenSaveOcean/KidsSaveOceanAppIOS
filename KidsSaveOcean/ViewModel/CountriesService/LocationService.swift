//
//  LocationService.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/13/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

class LocationService: NSObject {
    
    static var shared = LocationService()
    
    lazy var locationManager = { () -> CLLocationManager in

        let lmanager = CLLocationManager()
        lmanager.delegate = self
        return lmanager
    }()
    
    var authorizationStatus: Bool = false
    
    func autorizeLocation(completionHandler: (() -> Void)?) {
        
        let status = CLLocationManager.authorizationStatus()

        switch status {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationStatus = true
            completionHandler?()

        default:
            break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = [.authorizedAlways, .authorizedWhenInUse].contains(status)
    }
}
