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
    
    private static var sharedLocationService: LocationService = {
        let locationService = LocationService()
        
        return locationService
    }()
    
    class func shared() -> LocationService {
        return sharedLocationService
    }
    
    lazy var locationManager = { () -> CLLocationManager in
        let lmanager = CLLocationManager()
        lmanager.delegate = self
        return lmanager
    }()
    
    var authorizationStatus: Bool = false
    
    func autorizeLocation(completionHandler: (() -> Void)?) {
        
        //guard CLLocationManager.locationServicesEnabled() else { return }
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            break
            
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationStatus = true
            completionHandler?()

        @unknown default:
            break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = [.authorizedAlways, .authorizedWhenInUse].contains(status)
    }
}
