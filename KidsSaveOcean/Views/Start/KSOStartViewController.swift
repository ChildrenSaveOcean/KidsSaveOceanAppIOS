//
//  KSOStartViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 13/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartClick(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "AlreadyStart")
    }

}
