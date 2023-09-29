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
    
    override var originalWebUrlString: String {
        return  ServerPath.action_alert.string
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearNotifications()
    }

}
