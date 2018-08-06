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

        title = selectedCountry
    }

}
