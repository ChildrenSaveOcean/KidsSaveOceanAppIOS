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
    
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBOutlet weak var signaturesReqdTextField: UITextField!
    
    @IBOutlet weak var signaturesCollectedTextField: UITextField!
    
    @IBOutlet weak var liveLocationView: UIView!
    @IBOutlet weak var chooseLocationView: UIView!
    
    @IBOutlet weak var signaturesRequiredLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var signaturesTotalCollectedLabel: UILabel!
    
    private lazy var countriesData = CountriesService.shared().countriesContacts.sorted(by: {$0.name < $1.name})
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        liveLocationView.isHidden = true
        
        let attributedString = NSMutableAttributedString(string: "Policy chosen: Establish a sustainable environment as a human right!")
        
        let length = attributedString.length
        let range = NSRange(location: 0, length: 14)
        let font =  UIFont(name: "SF-Pro-Text-Regular", size: 15) ?? UIFont.systemFont(ofSize: 20)
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)

        let boldFont =  UIFont(name: "SF-Pro-Text-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 20)
        let boldRange = NSRange(location: range.length + 1, length: length-range.length - 2)
        attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)

        
        policyLabel.attributedText = attributedString
        
        pickerView.layer.borderColor = UIColor.darkGray.cgColor
        pickerView.layer.borderWidth = 1
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

    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
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
