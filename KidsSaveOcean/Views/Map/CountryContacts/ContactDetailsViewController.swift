//
//  ContactDetailsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!

    var selectedCountry: CountryContact?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateAddress()
    }

    private func updateAddress() {
        if let address = selectedCountry?.address {
            adressLabel.text = address
        } else {
            adressLabel.text = "Sorry, but we don't have information about this country yet."
        }
    }
}
