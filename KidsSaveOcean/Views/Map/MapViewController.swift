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
    
    var _countriesData: [CountryContact]? = nil
    var countriesData: [CountryContact] {
        get {
            if _countriesData != nil {
                return _countriesData!
            } else {
                _countriesData = CountriesService.shared()
                    .countriesContacts
                    .filter({$0.letters_written > 0})
                    .sorted(by: { (first, second) -> Bool in
                        first.letters_written > second.letters_written
                    })
                return _countriesData!
            }
        }
        set {
            _countriesData = newValue
        }
    }
    
//    lazy var countriesData: [CountryContact]? = { () -> [CountryContact] in
//        return CountriesService.shared()
//            .countriesContacts
//            .filter({$0.letters_written > 0})
//            .sorted(by: { (first, second) -> Bool in
//                first.letters_written > second.letters_written
//            })
//    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadScores), name: NSNotification.Name(Settings.CountriesHasBeenLoadedNotificationName), object: nil)
        
        map.register(KSOCustomMapPin.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        tbvTop10.register(UINib(nibName: "KSOMapTop10TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        let summaryLettersWritten = countriesData.reduce(0){$0 + $1.letters_written}
        lblLettersWritten.text = String(summaryLettersWritten)
        lblNumberCountries.text = String(countriesData.count)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count < 11 ? countriesData.count : 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tbvTop10.dequeueReusableCell(withIdentifier: "cell") as! KSOMapTop10TableViewCell
        cell.number.text = String(indexPath.row + 1)
        cell.lblCountryName.text = countriesData[indexPath.row].name
        cell.lblNumberOfLetters.text = String(countriesData[indexPath.row].letters_written)

        return cell
    }

    func reloadMap() {
        addPinsInMap()
        self.map.reloadInputViews()
        showMaxLettersScoreRegion()
        self.tbvTop10.reloadData()
    }

    // MARK: backend methods
    func addPinsInMap() {
        for country in countriesData {
            if country.coordinates != nil {
                let annotation = KSOPinOfLetters(with: country.name, country.coordinates!, country.letters_written)
                map.addAnnotation(annotation)
            }
        }
    }

    private func showMaxLettersScoreRegion() {
        guard let maxLettersCountry = countriesData.first else { return }
        guard let coordinates = maxLettersCountry.coordinates else { return }
        
        let region = MKCoordinateRegion(center: coordinates, span: map.region.span)
        map.setRegion(region, animated: true)
    }
    
    func showCountry(_ country:CountryContact) {
        guard let coordinates = country.coordinates else { return }
        
        let region = MKCoordinateRegion(center: coordinates, span: map.region.span)
        map.setRegion(region, animated: true)
    }
    
    @objc private func reloadScores() {
        _countriesData = nil
        tbvTop10.reloadData()
        reloadMap()
    }
}
