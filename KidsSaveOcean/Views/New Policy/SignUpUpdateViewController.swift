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
    
    @IBOutlet weak var signaturesBlock: UIStackView!
    @IBOutlet weak var collectedSingaturesUpdateButton: UIButton!
    @IBOutlet weak var signaturesReqdTextField: UITextField!
    @IBOutlet weak var signaturesCollectedTextField: UITextField!
    
    @IBOutlet weak var liveLocationView: UIView!
    @IBOutlet weak var chooseLocationView: UIView!
    @IBOutlet weak var pickerViewHeightConstraint: KSOLayoutConstraint!
    @IBOutlet weak var baseStackViewBottonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signaturesRequiredLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var signaturesTotalCollectedLabel: UILabel!
    
    @IBOutlet weak var liveCampaingStateLabel: UILabel!
    @IBOutlet weak var unliveLocationMessageLabel: UILabel!
    
    let liveCampaignLocationStateMessages = [false: "Live campaigns: none - still building",
                                             true: "Your location is live: "]
    
    var selectedCountryForCampaign: HijackLocation?
    
    private lazy var citiesData = HijackPLocationViewModel.shared().hidjackPLocations
//    private lazy var citiesData = { () -> [HijackLocation] in
//        let userHijackPolicy = UserViewModel.shared().hijack_policy_selected
//        let campaigns = CampaignViewModel.shared().campaigns.filter({$0.hijack_policy == userHijackPolicy}).map({$0.location_id})
//        return HijackPLocationViewModel.shared().hidjackPLocations.filter({
//            campaigns.contains($0.id)
//        })
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(aNotification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(aNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.setHidingKeyboardWhenTappedAround()
        
        if UIScreen.main.bounds.height > 800 {
            pickerViewHeightConstraint.constant = 216
            baseStackViewBottonConstraint.constant = 40
        } else {
            pickerViewHeightConstraint.constant = 100
            baseStackViewBottonConstraint.constant = 20
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
        
        unliveLocationMessageLabel.isHidden = true
        liveCampaingStateLabel.text = ""
        
        let img: UIImage = #imageLiteral(resourceName: "UpdateWhite")
        collectedSingaturesUpdateButton.setImage(img, for: .disabled)
        
        pickerView.layer.borderColor = UIColor.darkGray.cgColor
        pickerView.layer.borderWidth = 1
        
        signaturesReqdTextField.layer.borderColor = UIColor.gray.cgColor
        signaturesReqdTextField.layer.borderWidth = 1.0
        signaturesReqdTextField.roundCorners()
        
        signaturesCollectedTextField.layer.borderColor = UIColor.gray.cgColor
        signaturesCollectedTextField.layer.borderWidth = 1.0
        signaturesCollectedTextField.roundCorners()
        
        showLocationView()
    }

    // MARK: Action methods
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Are you sure you want to choose this location?", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            //SEND it to backend or store in usermodel
            if let selectedCountryForCampaign = self.selectedCountryForCampaign {
                UserViewModel.shared().campain?.campaign_id = selectedCountryForCampaign.id
                UserViewModel.shared().saveUser()
                self.liveLocationView.isHidden = true
                self.chooseLocationView.isHidden = false
                self.showLocationView()
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
    
    // MARK: Private methods
    private func showLocationView() {
        let userCampaign = UserViewModel.shared().campain
        let campaignLive = userCampaign != nil ? CampaignViewModel.shared().campaigns.filter({$0.id == userCampaign?.campaign_id}).first?.live : false
        
        if campaignLive == true {

            liveLocationView.isHidden = false
            chooseLocationView.isHidden = true
            
            updateLiveLocationView()
            
        } else {
            
            liveLocationView.isHidden = true
            chooseLocationView.isHidden = false
            
            signaturesReqdTextField.text = "0"
            signaturesCollectedTextField.text = "0"
            
            var currentCampaignLocationNum = 0
            if userCampaign?.campaign_id != nil,
                let userCampaignLocationId = CampaignViewModel.shared().campaigns.filter({$0.id == userCampaign?.campaign_id}).first?.location_id {
                currentCampaignLocationNum = citiesData.firstIndex(where: { (location) -> Bool in
                    return location.id == userCampaignLocationId
                }) ?? 0
                
            }
            
            if currentCampaignLocationNum == 0 {
                let locale = Locale.current
                if let code = locale.regionCode,
                    let countryStr = locale.localizedString(forRegionCode: code) {
                    let country = countryStr == "United States" ? "USA" : countryStr
                    currentCampaignLocationNum = citiesData.firstIndex(where: {$0.location.contains(country)}) ?? citiesData.count/2
                }
            }
            
            pickerView.selectRow(currentCampaignLocationNum, inComponent: 0, animated: true)
        }
        
        signaturesBlock.alpha = userCampaign?.campaign_id != nil ? 1 : 0
        
    }
    
    private func updateLiveLocationView() {
        let campaign = UserViewModel.shared().campain
        signaturesRequiredLabel.text = String( campaign?.signatures_pledged ?? 0)
        signaturesTotalCollectedLabel.text = String(campaign?.signatures_collected ?? 0)
        deadlineLabel.text = "--" //campaign["signatures_pledged"] as? String ?? "--" // TODO
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountryForCampaign = citiesData[row]
        let userHijackPolicyChosen = UserViewModel.shared().hijack_policy_selected
        let campaign = CampaignViewModel.shared().campaigns.filter({
            $0.hijack_policy == userHijackPolicyChosen &&
                $0.location_id == selectedCountryForCampaign?.id
            }).first
        
        if selectedCountryForCampaign != nil,
            campaign != nil,
            campaign?.live == true {
            unliveLocationMessageLabel.isHidden = true
            liveCampaingStateLabel.text = liveCampaignLocationStateMessages[true]! + selectedCountryForCampaign!.location
            signaturesCollectedTextField.isEnabled = true
            collectedSingaturesUpdateButton.isEnabled = true
            
        } else {
            unliveLocationMessageLabel.isHidden = false
            liveCampaingStateLabel.text = liveCampaignLocationStateMessages[false]
            signaturesCollectedTextField.isEnabled = false
            collectedSingaturesUpdateButton.isEnabled = false
        }
        
    }
}
