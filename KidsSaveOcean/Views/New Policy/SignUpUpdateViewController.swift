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
    @IBOutlet weak var chooseLocationButton: UIButton!
    
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
    
    private lazy var userHijackPolicy = UserViewModel.shared().hijack_policy_selected
    private lazy var campaigns = CampaignViewModel.shared().campaigns.filter({$0.hijack_policy == userHijackPolicy})
    private lazy var campaignLocations = HijackPLocationViewModel.shared().hidjackPLocations.filter({ campaigns.map({$0.location_id}).contains($0.id) })
    
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
        
        let attrPolicyStr = NSMutableAttributedString(string: "Policy chosen: ")
        let font = UIFont.proRegular15
        attrPolicyStr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attrPolicyStr.length))
        
        let policyDescr = HijackPoliciesViewModel.shared().hidjackPolicies.filter {$0.id == userHijackPolicy}.first?.description ?? ""
        let attrPolicyDescrStr = NSMutableAttributedString(string: policyDescr)
        let boldFont = UIFont.proSemiBold15
        attrPolicyDescrStr.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 0, length: attrPolicyDescrStr.length))

        let resultPolicyStr = NSMutableAttributedString()
        resultPolicyStr.append(attrPolicyStr)
        resultPolicyStr.append(attrPolicyDescrStr)
        policyLabel.attributedText =  resultPolicyStr //attributedString
        
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

            let num = self.pickerView.selectedRow(inComponent: 0)
            guard let campaign = self.campaigns.filter({$0.location_id == self.campaignLocations[num].id}).first else {
                return
            }
            
            let campSign = CampaignSignatures(campaign_id: campaign.id, signatures_pledged: campaign.signatures_pledged, signatures_collected: 0)
            UserViewModel.shared().campaign = campSign
            
            UserViewModel.shared().saveUser()
            
            self.liveLocationView.isHidden = true
            self.chooseLocationView.isHidden = false
            self.showLocationView()
            self.view.setNeedsLayout()
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
            UserViewModel.shared().campaign?.signatures_pledged = Int(signatures) ?? 0
            UserViewModel.shared().saveUser()
            signaturesReqdTextField.text = ""
            dismissKeyboard()
            updateLiveLocationView()
        }
    }
    
    @IBAction func collectedSignaturesClicked(_ sender: Any) {
        if let signatures = signaturesCollectedTextField.text {
            UserViewModel.shared().campaign?.signatures_collected = Int(signatures) ?? 0
            UserViewModel.shared().saveUser()
            signaturesCollectedTextField.text = ""
            dismissKeyboard()
            updateLiveLocationView()
        }
    }
    
    // MARK: Private methods
    private func showLocationView() {
        let userCampaign = UserViewModel.shared().campaign
        let campaignLive = userCampaign != nil ? campaigns.filter({$0.id == userCampaign?.campaign_id}).first?.live : false
        
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
                let userCampaignLocationId = campaigns.filter({$0.id == userCampaign?.campaign_id}).first?.location_id {
                currentCampaignLocationNum = campaignLocations.firstIndex(where: { (location) -> Bool in
                    return location.id == userCampaignLocationId
                }) ?? 0
                pickerView.selectRow(currentCampaignLocationNum, inComponent: 0, animated: true)
                setCampaignLiveDescription(currentCampaignLocationNum)
            } else if campaignLocations.count == 0 || userHijackPolicy.isEmpty {
                pickerView.isUserInteractionEnabled = false
                chooseLocationButton.isEnabled = false
                chooseLocationButton.alpha = 0.5
            } else {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                setCampaignLiveDescription(0)
            }
            
//            if currentCampaignLocationNum == 0 {
//                let locale = Locale.current
//                if let code = locale.regionCode,
//                    let countryStr = locale.localizedString(forRegionCode: code) {
//                    let country = countryStr == "United States" ? "USA" : countryStr
//                    currentCampaignLocationNum = citiesData.firstIndex(where: {$0.location.contains(country)}) ?? citiesData.count/2
//                }
//            }
            
        }
        
        if userCampaign != nil,
            !(userCampaign!.campaign_id.isEmpty) {
            signaturesBlock.alpha = 1
        } else {
            signaturesBlock.alpha = 0
        }
        
    }
    
    private func setCampaignLiveDescription(_ num: Int) {
        selectedCountryForCampaign = campaignLocations[num]
        
        let campaign = campaigns.filter({ $0.location_id == selectedCountryForCampaign?.id }).first
        
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
    
    private func updateLiveLocationView() {
        let campaign = UserViewModel.shared().campaign
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
        return campaignLocations.count
    }
}

// MARK: - UIPickerViewDelegate
extension SignUpUpdateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: campaignLocations[row].location, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setCampaignLiveDescription(row)
        
//        let campaign = campaigns.filter({ $0.location_id == selectedCountryForCampaign?.id }).first
//
//        if selectedCountryForCampaign != nil,
//            campaign != nil,
//            campaign?.live == true {
//            unliveLocationMessageLabel.isHidden = true
//            liveCampaingStateLabel.text = liveCampaignLocationStateMessages[true]! + selectedCountryForCampaign!.location
//            signaturesCollectedTextField.isEnabled = true
//            collectedSingaturesUpdateButton.isEnabled = true
//        } else {
//            unliveLocationMessageLabel.isHidden = false
//            liveCampaingStateLabel.text = liveCampaignLocationStateMessages[false]
//            signaturesCollectedTextField.isEnabled = false
//            collectedSingaturesUpdateButton.isEnabled = false
//        }
    }
}
