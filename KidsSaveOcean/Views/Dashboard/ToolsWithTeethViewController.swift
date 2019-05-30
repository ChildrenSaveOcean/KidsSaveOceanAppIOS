//
//  ToolsWithTeethViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 3/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class ToolsWithTeethViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func showStudentsResources(_ sender: Any) {
        tabBarController?.selectedIndex = 3
        guard let navVC = tabBarController?.selectedViewController as? UINavigationController else {return}

        if let resources = navVC.viewControllers.first as? ResourcesViewController {
            resources.webUrlString = "https://www.kidssaveocean.com/studentresources"
            //resources.loadPage()
        }
    }

}
