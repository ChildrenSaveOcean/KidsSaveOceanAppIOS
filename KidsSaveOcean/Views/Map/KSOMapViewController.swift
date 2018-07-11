//
//  KSOMapViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 11/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

class KSOMapViewController: UIViewController {

    
    var letters = [MKAnnotation]()
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        returnLetters()
        addPinsInMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnLetters() {
        // TODO: Put the stored data here and delete the test data
        let test = KSOPinOfLetters(with: "Brazil", CLLocationCoordinate2D(latitude: -3.98, longitude: -38.61), 2)
        let test2 = KSOPinOfLetters(with: "Czech Republic", CLLocationCoordinate2D(latitude: 49.20, longitude: 16.43), 15)
        let test3 = KSOPinOfLetters(with: "USA", CLLocationCoordinate2D(latitude: 36.18, longitude: -87.06), 35)
        
        self.letters.append(test)
        self.letters.append(test2)
        self.letters.append(test3)
    }
    
    func addPinsInMap() {
        for pin in letters {
            map.addAnnotation(pin)
        }
    }

}
