//
//  CountryContactsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

final class CountryContactsViewController: UIViewController, Instantiatable {

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
        selectedCountry = CountriesService.shared.getUserCountry()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.selectedCountry != nil,
            let indextOfCountry = viewModel.allCountries?.firstIndex(where: { (country) -> Bool in
                country.code == self.selectedCountry!.code
        }) {
            countriesPickerView.selectRow(indextOfCountry, inComponent: 0, animated: true)
        }
    }

    private func setupViewElements() {
        setupNavigationBar()

        submitButton.layer.cornerRadius = 5
    }

    private func setupNavigationBar() {
        title = "Country Contacts"

        let fontColor = UIColor.white
        let titleLalel = UILabel()

        let attributedString = NSMutableAttributedString(string: "Country Contacts")

        let length = attributedString.length
        let range = NSRange(location: 0, length: length)
        let font = UIFont.proRegular20
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: range)

        titleLalel.attributedText = attributedString
        titleLalel.adjustsFontSizeToFitWidth = true
        titleLalel.minimumScaleFactor = 0.5

        navigationItem.titleView = titleLalel
    }

    // MARK: - Actions
    @objc func dismissView() {
        navigationController?.popViewController(animated: true)
    }

    private let countryListToContactDetailsSegue = "countryListToContactDetailsSegue"
    @IBAction func submitButtonPressed(_ sender: Any) {
        if viewModel.countriesContacts.count > 0 {
            self.performSegue(withIdentifier: countryListToContactDetailsSegue, sender: self)

            return
        }

        self.activityIndicator.startAnimating()

        viewModel.fetchContacts { [unowned self] in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: self.countryListToContactDetailsSegue, sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ContactDetailsViewController else {
            return
        }

        if let selectedCountry = selectedCountry {
            destination.selectedCountry = viewModel.contact(of: selectedCountry.code) //(of: selectedCountry.name)
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
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: viewModel.allCountries?[row].name ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = viewModel.allCountries?[row]
    }
}
