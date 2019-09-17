//
//  CreateNewEnvironmentPolicyViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/16/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class CreateNewEnvironmentPolicyViewController: UIViewController, Instantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension CreateNewEnvironmentPolicyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnvironmentCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let taskViewController = YouthInitiativeProcessViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
            case 1:
                let taskViewController = Follow7StepsViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
            case 2:
                let taskViewController = VoteNowViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
            case 3:
                let taskViewController = SignUpUpdateViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
            case 4:
                let taskViewController = MultiplympactViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
            case 5:
                let taskViewController = TrackTheHijackViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
            default:
                let taskViewController = YouthInitiativeProcessViewController.instantiate()
                taskViewController.title = ""
                navigationController?.pushViewController(taskViewController, animated: true)
        }
    }
}
