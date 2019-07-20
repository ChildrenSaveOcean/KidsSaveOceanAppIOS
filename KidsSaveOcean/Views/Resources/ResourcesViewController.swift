//
//  ResourcesViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit

class ResourcesViewController: WebIntegrationViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        setURLString("https://www.kidssaveocean.com/fatechanger-resources")
    }
}
