//
//  ViewController+ExtentionViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setHidingKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true //false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
