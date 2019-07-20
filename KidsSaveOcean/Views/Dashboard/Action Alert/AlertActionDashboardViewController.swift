//
//  AlertActionDashboardViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 3/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class AlertActionDashboardViewController: WebIntegrationViewController, Instantiatable, NotificationProtocol {
    var notificationTargets: [NotificationTarget] = [.actionAlert]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setURLString("https://www.kidssaveocean.com/action-alert")
    }

}
