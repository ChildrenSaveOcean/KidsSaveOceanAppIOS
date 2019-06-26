//
//  Task5ViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/26/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController, Instantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func policyToolkitAction(_ sender: Any) {
        tabBarController?.selectedIndex = 3
        guard let navVC = tabBarController?.selectedViewController as? UINavigationController else {return}

        if let resources = navVC.viewControllers.first as? ResourcesViewController {
            resources.webUrlString = "https://www.kidssaveocean.com/studentresources"
        }
    }

}
