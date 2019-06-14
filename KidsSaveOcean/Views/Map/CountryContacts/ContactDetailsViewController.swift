//
//  ContactDetailsViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import SnapKit

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateViewConstraints()
    }

    private func updateAddress() {
        if let address = selectedCountry?.address {
            adressLabel.text = address
        } else {
            adressLabel.text = "Sorry, but we don't have information about this country yet."
        }
    }

    override func updateViewConstraints() {
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width

        let itemsMargin = screenHeight * 0.02
        let bottomOffset = screenHeight * 0.015

        headerImageView.snp.updateConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(screenHeight * 0.55)
        }

        descriptionLabel.snp.updateConstraints { (make) in
            make.left.equalTo(view).offset(itemsMargin)
            make.top.equalTo(headerImageView.snp.bottom).offset(itemsMargin)
        }

        adressLabel.snp.updateConstraints { (make) in
            make.left.equalTo(view).offset(itemsMargin)
            make.right.equalTo(view).offset(-itemsMargin)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(itemsMargin)
            make.bottom.lessThanOrEqualTo(instructionLabel.snp.top)
        }

        instructionLabel.snp.updateConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-tabBarController!.tabBar.frame.height - bottomOffset)
            make.width.equalTo(screenWidth * 0.9)
        }

        super.updateViewConstraints()
    }
}
