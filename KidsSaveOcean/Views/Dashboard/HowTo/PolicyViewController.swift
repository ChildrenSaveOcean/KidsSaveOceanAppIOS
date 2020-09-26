//
//  Task5ViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/26/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController, Instantiatable {

    @IBAction func policyToolkitAction(_ sender: Any) {
        tabBarController?.switchToHomeScreen()
        guard let homeViewController = tabBarController?.getSelectedTabMainViewController() as? HomeTableViewController else { return }
        
        let taskViewController = CreateNewEnvironmentPolicyViewController.instantiate()
        taskViewController.title = ""
        homeViewController.navigationController?.pushViewController(taskViewController, animated: true)
        navigationController?.popViewController(animated: false)
    }

}
