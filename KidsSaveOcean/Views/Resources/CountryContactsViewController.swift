//
//  CountryContactsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import CountryPickerView

final class CountryContactsViewController: UIViewController {
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    
    private let viewModel = CountryContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCountryPickerView()
    }
    
    func setupNavigationBar() {
        title = "Country Contacts"
        
        let image = UIImage.init(named: "CancelBarButtonItem")
        let cancelButton = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupCountryPickerView() {
        countryPickerView.delegate = self
        countryPickerView.showPhoneCodeInView = false
        
        countryPickerView.layer.cornerRadius = 5.0
        countryPickerView.layer.borderColor = UIColor(red: 0.05, green: 0.37, blue: 0.87, alpha: 1).cgColor
        countryPickerView.layer.borderWidth = 0.5
        
        countryPickerView.countryDetailsLabel.text = countryPickerView.selectedCountry.name
        countryPickerView.countryDetailsLabel.textAlignment = .center
        countryPickerView.countryDetailsLabel.font = UIFont.systemFont(ofSize: 18)
        countryPickerView.flagSpacingInView = -35
        countryPickerView.flagImageView.isHidden = true
    }
    
    // MARK: - Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapView(_ sender: Any) {
        countryTextField.endEditing(true)
    }
}

// MARK: - CountryPickerViewDelegate
extension CountryContactsViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryPickerView.countryDetailsLabel.text = country.name
    }
}
