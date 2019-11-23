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
    
    var pickerData = HijackPoliciesViewModel.shared().hidjackPolicies.sorted {$0.id < $1.id}
    
    var selectedPolicy: HijackPolicy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.height > 800 {
                self.pickerViewHeightConstraint.constant *= 2.1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let userHijackPolicy = UserViewModel.shared().hijack_policy_selected
        
        let num = userHijackPolicy.isEmpty ? pickerData.count/2 : pickerData.firstIndex(where: {$0.id == userHijackPolicy}) ?? 0
        let policy = pickerData[num]
        pickerView.selectRow(num, inComponent: 0, animated: true)
        setPolicyDetails(policy)
    }
    
    @IBAction func voteNowButton() {
        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy?", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            if let selectedPolicy = self.selectedPolicy {
//                if UserViewModel.shared().hijack_policy_selected != selectedPolicy.id {
//                    UserViewModel.shared().campaign = nil
//                }
                UserViewModel.shared().hijack_policy_selected = selectedPolicy.id
                UserViewModel.shared().saveUser()
                HijackPoliciesViewModel.shared().updateVotes(policy: selectedPolicy, value: selectedPolicy.votes + 1)
                
            }
            self.pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
            self.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hijackPolicy = pickerData[row]
        setPolicyDetails(hijackPolicy)
    }
    
    private func setPolicyDetails(_ policy: HijackPolicy) {
        selectedPolicy = policy
        summaryLabel.text = policy.summary
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
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let hijackPolicy = pickerData[row]
        let attributedString = NSAttributedString(string: hijackPolicy.description, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
}
