//
//  LetterTrackerViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 12/5/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import SnapKit

final class LetterTrackerViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!

    private lazy var countriesData = CountriesService.shared().countriesContacts.sorted(by: {$0.name < $1.name})

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateViewConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let nearestCountry = CountriesService.shared().getUserCountry(),
            let indextOfCountry = countriesData.firstIndex(where: { (country) -> Bool in
                country.name == nearestCountry.name
            }) {
            pickerView.selectRow(indextOfCountry, inComponent: 0, animated: true)
        }
    }

    private func setupViewElements() {
        setupNavigationBar()
        setupSubmitButton()
    }

    private func setupNavigationBar() {
        let fontColor = UIColor.black
        let titleLalel = UILabel()

        let attributedString = NSMutableAttributedString(string: "Letter Tracker")

        let length = attributedString.length
        let range = NSRange(location: 0, length: length)
        let font =  UIFont(name: "SF-Pro-Text-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)

        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: range)

        titleLalel.attributedText = attributedString
        navigationItem.titleView = titleLalel

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupSubmitButton() {
        submitButton.layer.cornerRadius = 5
    }

    @IBAction func enterLetterInTheTracker(_ sender: Any) {
        let viewAlert = UIAlertController(title: "Are you certain you've stamped and mailed it?", message: "", preferredStyle: .alert)
        viewAlert.addAction(UIAlertAction(title: "No, not yet", style: .cancel, handler: nil))
        viewAlert.addAction(UIAlertAction(title: "Yes, I've already mailed it!", style: .default, handler: { _ in
            self.updateLettersTracker()
        }))
        self.present(viewAlert, animated: true, completion: nil)

    }

    private func updateLettersTracker() {

        let selectedCountryNum = pickerView.selectedRow(inComponent: 0)
        let selectedCountry = countriesData[selectedCountryNum]
        CountriesService.shared().increaseLettersWrittenForCountry(selectedCountry)
        
        let viewAlert = UIAlertController(title: "Your Letter Has Been Recorded", message: "Congratilations! You're one of us now. A Fatechanger.", preferredStyle: .alert)
        viewAlert.addAction(UIAlertAction(title: "Fatechangers click here", style: .default, handler: { _ in
            self.gotoDashBoard()
        }))
        self.present(viewAlert, animated: true, completion: nil)
    }

    private func gotoDashBoard() {
        tabBarController?.selectedIndex = 2

        guard let navigationController = tabBarController?.selectedViewController as? UINavigationController  else { return }

        guard let dashboardVC = navigationController.viewControllers.first as? DashboardViewController
            else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            if dashboardVC.meterPointer != nil { //// TODO
                dashboardVC.switchTask2(self)
            }
        }
    }

}

// MARK: - UIPickerViewDataSource
extension LetterTrackerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesData.count
    }
}

// MARK: - UIPickerViewDelegate
extension LetterTrackerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = countriesData[row].name
        label.textAlignment = .center

        return label
    }
}
