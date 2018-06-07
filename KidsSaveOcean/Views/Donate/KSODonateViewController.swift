//
//  KSODonateViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 06/06/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSODonateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //change the status bar to white
        UIApplication.shared.statusBarStyle = .lightContent
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change the status bar to white
    //TODO: Best option is create an extension to all views with white bar need
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
   

}
