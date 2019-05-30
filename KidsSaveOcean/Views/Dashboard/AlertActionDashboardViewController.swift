//
//  AlertActionDashboardViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 3/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class AlertActionDashboardViewController: WebIntegrationViewController {

    override func loadPage() {
        self.webUrlString = "https://www.kidssaveocean.com/action-alert"
        super.loadPage()
    }
    
}
