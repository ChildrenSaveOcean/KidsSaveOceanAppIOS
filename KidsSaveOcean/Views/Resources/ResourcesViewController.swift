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

    /*override var webUrlString: String {
        get { return "https://www.kidssaveocean.com/fatechanger-resources" }
        set(newValue) {
            print("here we set the main url to " + newValue)
            self.webUrlString = newValue
        }
    }*/
    //override func viewDidLoad() {
        //super.viewDidLoad()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func loadPage() {
        if webUrlString.count == 0 {
            webUrlString = "https://www.kidssaveocean.com/fatechanger-resources"
        }
        super.loadPage()
    }
}
