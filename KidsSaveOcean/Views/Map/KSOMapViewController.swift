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

class KSOMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //# MARK: Var, lets and outlets

    var ref : DatabaseReference!
    var letters = [MKAnnotation]()
    var countriesLetters = [String:Int]()
    var numberOfLetters = 0
    var orderedCountries = [(String, Int)]()
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lblLettersWritten: UILabel!
    @IBOutlet weak var lblNumberCountries: UILabel!
    @IBOutlet weak var tbvTop10: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
  
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.map.isHidden = true
            self.tbvTop10.isHidden = false
        } else {
            self.map.isHidden = false
            self.tbvTop10.isHidden = true
        }
    }
    
    
    //#MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.register(KSOCustomMapPin.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        tbvTop10.register(UINib(nibName: "KSOMapTop10TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        returnLetters()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //#MARK: table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesLetters.count < 11 ? countriesLetters.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tbvTop10.dequeueReusableCell(withIdentifier: "cell") as! KSOMapTop10TableViewCell
        cell.lblCountryName.text = orderedCountries[indexPath.row].0
        cell.lblNumberOfLetters.text = String(orderedCountries[indexPath.row].1)
        return cell
    }
    
    func reloadMap(){
        addPinsInMap()
        self.map.reloadInputViews()
        self.tbvTop10.reloadData()
        orderedCountries = countriesLetters.sorted { $0.1 > $1.1 }
    }
    
    //#MARK: backend methods
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
                        if let numberOfLettersOfThisCountry:Int = Int((pinInfo.value as? String)!) {
                            self.numberOfLetters += numberOfLettersOfThisCountry
                        }
                        break
                    default: break
                    }
                }
                    //isso ta errado
                self.countriesLetters[pinInfos["country"]!] = Int(pinInfos["numberOfLetters"]!)
                let newPin = KSOPinOfLetters(with:  pinInfos["country"]!, CLLocationCoordinate2D(latitude: Double(pinInfos["latitude"]!)!, longitude: Double(pinInfos["longitude"]!)!), Int(pinInfos["numberOfLetters"]!)!)
                    self.letters.append(newPin)
                    self.reloadMap()
            }
            
            // change the label
            self.lblNumberCountries.text! = "\(self.countriesLetters.count)"
            self.lblLettersWritten.text! = "\(self.numberOfLetters)"
            
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
