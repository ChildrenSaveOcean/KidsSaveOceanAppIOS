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
    
    var selectedCountryForCampaign: HijackLocation?
    private lazy var citiesData = HijackPLocationViewModel.shared().hidjackPLocations
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserViewModel.shared().campain["campaign_id"] != nil {
            liveLocationView.isHidden = false
            let campaign = UserViewModel.shared().campain
            print(campaign)
            signaturesRequiredLabel.text = "\(String(describing: campaign["signatures_required"]))"
            deadlineLabel.text = "\(String(describing: campaign["signatures_pledged"]))"
            signaturesTotalCollectedLabel.text = "\(String(describing: campaign["signatures_collected"]))"
        } else {
            liveLocationView.isHidden = true
            signaturesReqdTextField.text = "0"
            signaturesCollectedTextField.text = "0"
        }
        
        
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
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
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
        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy.", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //SEND it to backend or store in usermodel
            if let selectedCountryForCampaign = self.selectedCountryForCampaign {
                UserViewModel.shared().campain["campaign_id"] = selectedCountryForCampaign
                UserViewModel.shared().saveUser()
            }
            self.dismiss(animated: false, completion: nil)
            
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func plannedSignaturesClicked(_ sender: Any) {
        if let signatures = signaturesReqdTextField.text {
            UserViewModel.shared().campain["signatures_pledged"] = signatures
            UserViewModel.shared().saveUser()
        }
    }
    
    @IBAction func collectedSignaturesClicked(_ sender: Any) {
        if let signatures = signaturesCollectedTextField.text {
            UserViewModel.shared().campain["signatures_collected"] = signatures
            UserViewModel.shared().saveUser()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountryForCampaign = citiesData[row]
        print(citiesData[row])
    }
}

// MARK: - UIPickerViewDataSource
extension SignUpUpdateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesData.count
    }
}

// MARK: - UIPickerViewDelegate
extension SignUpUpdateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: citiesData[row].location  , attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
}
