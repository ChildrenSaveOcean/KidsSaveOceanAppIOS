//
//  CountryContactsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class CountryContactsViewController: UIViewController {
    
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = "Country Contacts"
        
        let image = UIImage.init(named: "CancelBarButtonItem")
        let cancelButton = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapView(_ sender: Any) {
        countryTextField.endEditing(true)
    }
}
