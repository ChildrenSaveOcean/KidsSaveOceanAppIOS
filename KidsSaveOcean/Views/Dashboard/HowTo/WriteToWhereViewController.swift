//
//  WriteToWhereViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/11/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class WriteToWhereViewController: UIViewController, Instantiatable {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setStatusBarColor(UIColor.clear)
    }

    @IBAction func writeToWhereAction(_ sender: Any) {
        navigationController?.pushViewController(CountryContactsViewController.instantiate(), animated: true)
    }

    @IBAction func writeAboutWhatAction(_ sender: Any) {
        navigationController?.pushViewController(WriteAboutWhatViewController(), animated: true)
    }
}
