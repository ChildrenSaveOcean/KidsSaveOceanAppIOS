//
//  ContactDetailsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var selectedCountry: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = selectedCountry
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
