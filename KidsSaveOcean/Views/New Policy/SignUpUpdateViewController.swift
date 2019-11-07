//
//  SignUpUpdateViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

class SignUpUpdateViewController: UIViewController, Instantiatable {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBOutlet weak var signaturesReqdTextField: UITextField!
    @IBOutlet weak var signaturesCollectedTextField: UITextField!
    
    @IBOutlet weak var liveLocationView: UIView!
    @IBOutlet weak var chooseLocationView: UIView!
    @IBOutlet weak var locationViewHeightConstraint: KSOLayoutConstraint!
    
    @IBOutlet weak var signaturesRequiredLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var signaturesTotalCollectedLabel: UILabel!
    
    var selectedCountryForCampaign: HijackLocation?
    private lazy var citiesData = HijackPLocationViewModel.shared().hidjackPLocations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(aNotification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(aNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.setHidingKeyboardWhenTappedAround()
        
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
        
        signaturesReqdTextField.layer.borderColor = UIColor.gray.cgColor
        signaturesReqdTextField.layer.borderWidth = 1.0
        signaturesReqdTextField.roundCorners()
        
        signaturesCollectedTextField.layer.borderColor = UIColor.gray.cgColor
        signaturesCollectedTextField.layer.borderWidth = 1.0
        signaturesCollectedTextField.roundCorners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserViewModel.shared().campain?.campaign_id != nil {
            
            liveLocationView.isHidden = false
            chooseLocationView.isHidden = true
            
            updateLiveLocationView()
            
            let locale = Locale.current
            if let code = locale.regionCode,
                let countryStr = locale.localizedString(forRegionCode: code) {
                let country = countryStr == "United States" ? "USA" : countryStr
                let i = citiesData.firstIndex(where: {$0.location.contains(country)}) ?? citiesData.count/2
                pickerView.selectRow(i, inComponent: 0, animated: true)
            }
            
        } else {
            
            liveLocationView.isHidden = true
            chooseLocationView.isHidden = false
            
            signaturesReqdTextField.text = "0"
            signaturesCollectedTextField.text = "0"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {

        UserViewModel.shared().saveUser()
        super.viewDidDisappear(animated)
        
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy.", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            //SEND it to backend or store in usermodel
            if let selectedCountryForCampaign = self.selectedCountryForCampaign {
                UserViewModel.shared().campain?.campaign_id = selectedCountryForCampaign.id
                UserViewModel.shared().saveUser()
                self.liveLocationView.isHidden = true
                self.chooseLocationView.isHidden = false
                self.view.setNeedsLayout()
            }
            self.dismiss(animated: false, completion: nil)
            
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func plannedSignaturesClicked(_ sender: Any) {
        if let signatures = signaturesReqdTextField.text {
            UserViewModel.shared().campain?.signatures_pledged = Int(signatures) ?? 0
            UserViewModel.shared().saveUser()
            signaturesReqdTextField.text = ""
            dismissKeyboard()
            updateLiveLocationView()
        }
    }
    
    @IBAction func collectedSignaturesClicked(_ sender: Any) {
        if let signatures = signaturesCollectedTextField.text {
            UserViewModel.shared().campain?.signatures_collected = Int(signatures) ?? 0
            UserViewModel.shared().saveUser()
            signaturesCollectedTextField.text = ""
            dismissKeyboard()
            updateLiveLocationView()
        }
    }
    
    private func updateLiveLocationView() {
        let campaign = UserViewModel.shared().campain
        signaturesRequiredLabel.text = String( campaign?.signatures_pledged ?? 0)
        signaturesTotalCollectedLabel.text = String(campaign?.signatures_collected ?? 0)
        deadlineLabel.text = "--" //campaign["signatures_pledged"] as? String ?? "--" // TODO
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountryForCampaign = citiesData[row]
    }
    
    // MARK: Keyboard Delegate methods
    @objc func keyboardWillHide(aNotification: NSNotification) {
        let size = UIScreen.main.bounds.size
        UIView.animate(withDuration: 1.0) {
            self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
    }
    
    @objc func keyboardWillShow(aNotification: NSNotification) {
        guard let keyboardHeight = (aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {
            return
        }
        let size = UIScreen.main.bounds.size
        UIView.animate(withDuration: 1.0) {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: size.width, height: size.height)
        }
    }
    
    @objc func keyboardDidShow(aNotification: NSNotification) {
        guard let keyboardHeight = (aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {
            return
        }
        let size = UIScreen.main.bounds.size
        UIView.animate(withDuration: 1.0) {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: size.width, height: size.height)
        }
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
        let attributedString = NSAttributedString(string: citiesData[row].location, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
}
