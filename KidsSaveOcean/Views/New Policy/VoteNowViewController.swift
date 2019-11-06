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
    
    var pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
    
    var selectedPolicy: HijackPolicy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.height > 800 {
                self.pickerViewHeightConstraint.constant *= 2.1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
        
        let num = pickerData.count/2
        let policy = pickerData[num]
        pickerView.selectedRow(inComponent: num)
        setPolicyDetails(policy)
    }
    
    @IBAction func voteNowButton() {
        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy.", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            print("Ok button tapped")
            if let selectedPolicy = self.selectedPolicy {
                HijackPoliciesViewModel.shared().updateVotes(policy: selectedPolicy, value: selectedPolicy.votes + 1)
            }
            self.pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
            self.dismiss(animated: false, completion: nil)
            
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            print("Cancel button tapped")
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
