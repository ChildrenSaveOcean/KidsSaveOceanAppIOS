//
//  ShowLinkWithClearNotificatinStatusViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/30/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class ShowLinkWithClearNotificatinStatusViewController: WebIntegrationViewController, NotificationProtocol {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setNavigationButtons() {
        // we don't need here the custom navigation buttons
    }
    
    override func checkNavigationButtons() {
        // we don't need to define the availability of custom navigation buttons

        self.setStatusBarVisible()
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}
