//
//  ToolsWithTeethViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 3/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class ToolsWithTeethViewController: UIViewController, Instantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func showStudentsResources(_ sender: Any) {
        tabBarController?.switchToStudentResourcesScreen()
    }

}
