//
//  WriteToWhereViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/11/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class WriteToWhereViewController: UIViewController, Instantiatable {

    @IBAction func writeToWhereAction(_ sender: Any) {
        navigationController?.pushViewController(CountryContactsViewController.instantiate(), animated: true)
    }
}
