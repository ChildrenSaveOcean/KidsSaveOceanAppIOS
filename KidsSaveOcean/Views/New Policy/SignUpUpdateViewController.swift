//
//  SignUpUpdateViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class SignUpUpdateViewController: UIViewController, Instantiatable {

    @IBOutlet weak var pickerView: UIPickerView!
    
    private lazy var countriesData = CountriesService.shared().countriesContacts.sorted(by: {$0.name < $1.name})
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIPickerViewDataSource
extension SignUpUpdateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesData.count
    }
}

// MARK: - UIPickerViewDelegate
extension SignUpUpdateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: countriesData[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
}
