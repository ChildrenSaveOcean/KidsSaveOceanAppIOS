//
//  KSOMapViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 11/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //# MARK: Var, lets and outlets
    
    var segmentControlDefaultIndex = 0
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
        
        lblLettersWritten.text = String(LettersService.shared().letters.count)
        lblNumberCountries.text = String(LettersService.shared().mapPins.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        reloadMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segmentControl.selectedSegmentIndex = segmentControlDefaultIndex
        didChangeSegment(segmentControl)
    }

    //#MARK: table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LettersService.shared().mapPins.count < 11 ? LettersService.shared().mapPins.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tbvTop10.dequeueReusableCell(withIdentifier: "cell") as! KSOMapTop10TableViewCell
        cell.number.text = String(indexPath.row + 1)
        cell.lblCountryName.text = LettersService.shared().mapPins[indexPath.row].name
        cell.lblNumberOfLetters.text = String(LettersService.shared().mapPins[indexPath.row].numberOfLetters)
        
        return cell
    }
    
    func reloadMap(){
        addPinsInMap()
        self.map.reloadInputViews()
        showMaxLettersScoreRegion()
        self.tbvTop10.reloadData()
    }
    
    //#MARK: backend methods
    
    func addPinsInMap() {
        for pin in LettersService.shared().mapPins {
            map.addAnnotation(pin)
        }
    }
    
    private func showMaxLettersScoreRegion() {
        
        let maxPin = LettersService.shared().mapPins.max { (first: KSOPinOfLetters, second: KSOPinOfLetters) -> Bool in
            first.numberOfLetters > second.numberOfLetters
        }
        
        if maxPin != nil {
            let region = MKCoordinateRegion(center: maxPin!.coordinate, span: map.region.span)
            map.setRegion(region, animated: true)
        }
    }
}
