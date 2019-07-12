//
//  MediaViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class MediaViewController: WebIntegrationViewController, Instantiatable, NotificationProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        clearNotificationForTarget(.newsAndMedia)
        clearNotificationForTarget(.policyChange)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setURLString("https://www.kidssaveocean.com/updates")
    }
}

