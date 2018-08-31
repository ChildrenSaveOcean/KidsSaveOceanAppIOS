//
//  KSOMapViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 11/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class KSOMapViewController: UIViewController {

    var ref : DatabaseReference!
    var letters = [MKAnnotation]()
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        map.register(KSOCustomMapPin.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        returnLetters()
    }

    func reloadMap(){
        addPinsInMap()
        self.map.reloadInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnLetters() {
        ref = Database.database().reference()
        ref.child("MapPins").observeSingleEvent(of: .value, with: { (snapshot) in
            for pins in (snapshot.value as? NSDictionary)! {
                var pinInfos = [String:String]()
                for pinInfo in (pins.value as? NSDictionary)! {
                    switch pinInfo.key as? String {
                    case "country":
                        pinInfos["country"] = pinInfo.value as? String
                        break
                    case "latitude":
                        pinInfos["latitude"] = pinInfo.value as? String
                        break
                    case "longitude":
                        pinInfos["longitude"] = pinInfo.value as? String
                        break
                    case "numberOfLetters":
                        pinInfos["numberOfLetters"] = pinInfo.value as? String
                        break
                    default: break
                    }
                }
                
                    //isso ta errado
                let newPin = KSOPinOfLetters(with:  pinInfos["country"]!, CLLocationCoordinate2D(latitude: Double(pinInfos["latitude"]!)!, longitude: Double(pinInfos["longitude"]!)!), Int(pinInfos["numberOfLetters"]!)!)
                    self.letters.append(newPin)
                    self.reloadMap()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addPinsInMap() {
        for pin in letters {
            map.addAnnotation(pin)
        }
    }

}
