//
//  VoteNowViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class VoteNowViewController: UIViewController, Instantiatable {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var pickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var voteButton: UIButton!
    
    @IBOutlet weak var impactNumberLabel: UILabel!
    @IBOutlet weak var difficultyNumberLabel: UILabel!
    @IBOutlet weak var impactToDifficultyNumberLabel: UILabel!
    
   
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var pickerData = [HijackPolicy]()
    
    var selectedPolicy: HijackPolicy?
    
    private var policyImpactDifficulties = [
        "hijack_policy_01" : [7.2, 5.5, 1.3],
        "hijack_policy_02" : [8.8, 6.0, 1.5],
        "hijack_policy_03" : [6.8, 5.2, 1.3],
        "hijack_policy_04" : [8.8, 7.8, 1.1],
        "hijack_policy_05" : [8.0, 5.3, 1.5],
        "hijack_policy_06" : [7.0, 6.0, 1.2],
        "hijack_policy_07" : [8.5, 4.5, 1.9],
        "hijack_policy_08" : [9.2, 5.3, 1.7],
        "hijack_policy_09" : [7.2, 5.7, 1.3],
        "hijack_policy_10" : [8.2, 6.0, 1.4]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.height > 800 {
                self.pickerViewHeightConstraint.constant *= 2.1
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setPolicyLoadingState), name: .policiesHaveBeenLoaded, object: nil)
        setPolicyLoadingState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserTaskViewModel.shared.userType != .student {
            voteButton.isEnabled = false
            voteButton.alpha = 0.5
        }
    }
    
    @IBAction func voteNowButton() {

        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy?", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            if let selectedPolicy = self.selectedPolicy {
                UserTaskViewModel.shared.hijackPolicySelected = selectedPolicy.id
                UserTaskViewModel.shared.saveUser()
                HijackPoliciesViewModel.shared.updateVotes(policy: selectedPolicy, value: selectedPolicy.votes + 1)
                
            }
            //self.pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
            self.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        ok.setAppTextColor()
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        cancel.setAppTextColor()
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard  pickerData.count > 0 else {
            return
        }

        let hijackPolicy = pickerData[row]
        setPolicyDetails(hijackPolicy)
    }
    
    private func setPolicyDetails(_ policy: HijackPolicy) {

        selectedPolicy = policy
        summaryLabel.text = policy.summary
        
        guard let policyNumbers = policyImpactDifficulties[policy.id] else {
            return
        }

        impactNumberLabel.text = String(policyNumbers[0])
        difficultyNumberLabel.text = String(policyNumbers[1])
        impactToDifficultyNumberLabel.text = String(policyNumbers[2])
    }
    
    @objc private func setPolicyLoadingState() {

        if !HijackPoliciesViewModel.shared.policiesHaveBeenLoaded {
            blur.frame = view.bounds
            blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blur.alpha = 0.7
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
            
        } else {
            pickerData = HijackPoliciesViewModel.shared.hijackPolicies.sorted {$0.id < $1.id}
            
            blur.frame = .zero
            blur.alpha = 0.0
            activityIndicator.alpha = 0
            activityIndicator.stopAnimating()

            setPolicyControls()
        }
    }
    
    private func setPolicyControls() {

        pickerView.reloadAllComponents()
        
        let userHijackPolicy = UserTaskViewModel.shared.hijackPolicySelected
        
        if !userHijackPolicy.isEmpty {
            let alertMessage = UIAlertController(title: "", message: "Explore proposals FateChanger youth are considering for citizen ballot initiatives", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it", style: .cancel, handler: nil)
            action.setAppTextColor()
            alertMessage.addAction(action)
            
            self.present(alertMessage, animated: true) {
                self.voteButton.isEnabled = false
                self.voteButton.alpha = 0.5
            }
        }
        
        let policy = pickerData[0]
        pickerView.selectRow(0, inComponent: 0, animated: true)
        setPolicyDetails(policy)
    }
}

// MARK: - UIPickerViewDataSource
extension VoteNowViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}

// MARK: - UIPickerViewDelegate
extension VoteNowViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        label.text = pickerData[row].description
        label.textAlignment = .center
        label.font = UIFont.proDisplaySemiBold15
        
        label.textColor = .black
        return label
    }
}
