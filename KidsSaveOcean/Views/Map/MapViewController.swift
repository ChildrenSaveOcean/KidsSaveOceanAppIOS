//
//  KSOMapViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 11/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Instantiatable {

    //# MARK: Var, lets and outlets

    var segmentControlDefaultIndex = 0
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lblLettersWritten: UILabel!
    @IBOutlet weak var lblNumberCountries: UILabel!
    @IBOutlet weak var tbvTop10: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            self.map.isHidden = true
            self.tbvTop10.isHidden = false
            blinkTopScoreCellIfNeed()
        } else {
            self.map.isHidden = false
            self.tbvTop10.isHidden = true
        }
    }

    var _countriesData: [CountryContact]?
    var countriesData: [CountryContact] {
        get {
            if _countriesData != nil {
                return _countriesData!
            } else {
                _countriesData = CountriesService.shared()
                    .countriesContacts
                    .filter({$0.letters_written > 0})
                    .sorted { $0.letters_written > $1.letters_written }

                return _countriesData!
            }
        }
        set {
            _countriesData = newValue
        }
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appCyan], for: .normal)
        segmentControl.layer.borderWidth = 1.0
        segmentControl.layer.borderColor = UIColor.appCyan.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadScores), name: .countriesHasBeenLoaded, object: nil)

        map.delegate = self
        map.register(KSOCustomMapPin.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        tbvTop10.register(UINib(nibName: "KSOMapTop10TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

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
        guard let cell =  tbvTop10.dequeueReusableCell(withIdentifier: "cell") as? KSOMapTop10TableViewCell else { fatalError("Wrong cell type. There is expected KSOMapTop10TableViewCell") }
        cell.configure(countriesData[indexPath.row], num: indexPath.row + 1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
     }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return CGFloat.leastNonzeroMagnitude
     }
    
    func reloadMap() {
        if CountriesService.shared().contryContactsHasBeenLoaded {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        _countriesData = nil
        addPinsInMap()
        
        let summaryLettersWritten = countriesData.reduce(0) {$0 + $1.letters_written}
        lblLettersWritten.text = summaryLettersWritten > 0 ? String(summaryLettersWritten) : String(UserDefaultsHelper.letterNumber())
        lblNumberCountries.text = countriesData.count > 0 ? String(countriesData.count) : String(UserDefaultsHelper.countryLetterNumber())
        
        UserDefaultsHelper.saveLetterNumber(summaryLettersWritten)
        UserDefaultsHelper.saveCountryLetterNumber(countriesData.count)
        
        self.map.reloadInputViews()
        //showMaxLettersScoreRegion()
        self.tbvTop10.reloadData()
    }

    // MARK: backend methods
    func addPinsInMap() {
        map.removeAnnotations(map.annotations)
        for country in countriesData where country.coordinates != nil {
            let annotation = KSOPinOfLetters(with: country.name, country.coordinates!, country.letters_written, country.action)
            map.addAnnotation(annotation)
        }
    }

    private func showMaxLettersScoreRegion() {
        guard let maxLettersCountry = countriesData.first else { return }
        guard let coordinates = maxLettersCountry.coordinates else { return }

        let region = MKCoordinateRegion(center: coordinates, span: map.region.span)
        map.setRegion(region, animated: true)
    }

    func showCountry(_ country: CountryContact) {
        guard let coordinates = country.coordinates else { return }

        let region = MKCoordinateRegion(center: coordinates, span: map.region.span)
        map.setRegion(region, animated: true)
    }

    @objc private func reloadScores() {
        _countriesData = nil
        tbvTop10?.reloadData()
        reloadMap()
        blinkTopScoreCellIfNeed()
    }
    
    private func blinkTopScoreCellIfNeed() {
        guard isNotificationActualForTarget(.newHighScore) == true else {return}
        guard tbvTop10.isHidden == false else { return }
        guard let cell = self.tbvTop10.cellForRow(at: IndexPath(row: 0, section: 0)) as? KSOMapTop10TableViewCell else {return}
        cell.blinkBackColor(times: 5)
        clearNotifications()
    }
}

extension MapViewController: NotificationProtocol {
    var notificationTargets: [NotificationTarget] {
        return [.newHighScore]
    }
    
    func updateViews() {
        guard map != nil, tbvTop10 != nil else {return}
        reloadScores()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      
        guard let annotation = view.annotation as? KSOPinOfLetters,
            let action = annotation.action else { return }
        
        let webViewController = WebIntegrationViewController()
        
        self.present(webViewController, animated: true) {
            webViewController.setURLString(action.action_link)
      }
    }
}
