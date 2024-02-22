//
//  WriteAboutWhatViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/2/20.
//  Copyright © 2020 KidsSaveOcean. All rights reserved.
//

import UIKit

class WriteAboutWhatViewController: WebIntegrationViewController, Instantiatable {
    var notificationTargets: [NotificationTarget] = [.actionAlert]
    
    override var originalWebUrlString: String {
        return ServerPath.copy_of_write_letters_with_your_kid.string
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setNavigationButtons() {
        // we don't need here the custom navigation buttons
    }
    
    override func checkNavigationButtons() {
        // we don't need to define the availability of custom navigation buttons

        self.navigationController?.navigationBar.backgroundColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}
