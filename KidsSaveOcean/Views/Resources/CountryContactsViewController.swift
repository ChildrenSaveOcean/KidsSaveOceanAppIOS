//
//  CountryContactsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

final class CountryContactsViewController: UIViewController {
    
    @IBOutlet weak var whalesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var selectCountryLabel: UILabel!
    @IBOutlet weak var countriesPickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var selectedCountry: CountryContact?
    
    private lazy var viewModel = CountryContactsViewModel(databaseReferenece: Database.database().reference())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCountries()
        setupViewElements()
        selectedCountry = viewModel.allCountries?.first
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViewConstraints()
    }
    
    private func setupViewElements() {
        setupNavigationBar()
        
        submitButton.layer.cornerRadius = 5
    }
    
    private func setupNavigationBar() {
        title = "Country Contacts"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        let fontColor = UIColor.white
        let titleLalel = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "Country Contacts")
        
        let length = attributedString.length
        let range = NSMakeRange(0, length)
        let font =  UIFont(name: "SF-Pro-Text-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
        
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: fontColor, range: range)
        
        titleLalel.attributedText = attributedString
        titleLalel.adjustsFontSizeToFitWidth = true
        titleLalel.minimumScaleFactor = 0.5
        
        navigationItem.titleView = titleLalel
    }
    
    override func updateViewConstraints() {
    
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        whalesImageView.snp.updateConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(screenHeight * 0.4)
        }
        
        titleLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.lessThanOrEqualTo(view).offset(screenWidth * 0.01)
            make.top.equalTo(whalesImageView.snp.bottom).offset(screenHeight * 0.025)
        }
        
        descriptionLabel.snp.updateConstraints { (make) in
            make.centerX.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(screenHeight * 0.005)
        }
        
        selectCountryLabel.snp.updateConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(screenHeight * 0.025)
        }
        
        countriesPickerView.snp.updateConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(screenWidth * 0.8)
            make.top.equalTo(selectCountryLabel.snp.bottom).offset(-screenHeight * 0.01)
            make.bottom.equalTo(submitButton.snp.top).offset(-5)
        }
        
        submitButton.snp.updateConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-tabBarController!.tabBar.frame.height - 10)
            make.height.equalTo(screenHeight * 0.045)
            make.width.equalTo(screenWidth * 0.45)
        }
        
        activityIndicator.snp.updateConstraints { (make) in
            make.center.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if (viewModel.countriesContacts.count > 0) {
            self.performSegue(withIdentifier: "countryListToContactDetailsSegue", sender: self)
            
            return
        }
        
        self.activityIndicator.startAnimating()
        
        viewModel.fetchContacts { [unowned self] in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "countryListToContactDetailsSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ContactDetailsViewController else {
            return
        }
        
        if let selectedCountry = selectedCountry {
            destination.selectedCountry = viewModel.contact(of: selectedCountry.name)
        }
    }
}

// MARK: - UIPickerViewDataSource
extension CountryContactsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.allCountries?.count ?? 0
    }
}

// MARK: - UIPickerViewDelegate
extension CountryContactsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = viewModel.allCountries?[row].name
        label.textAlignment = .center
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = viewModel.allCountries?[row]
    }
}
