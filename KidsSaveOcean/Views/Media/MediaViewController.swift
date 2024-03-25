//
//  MediaViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class MediaViewController: WebIntegrationViewController, Instantiatable, NotificationProtocol {

    var notificationTargets: [NotificationTarget] = [.newsAndMedia, .policyChange]

    override var hideNavigationBarByDefault: Bool { return true }
    
    override var originalWebUrlString: String {
        return ServerPath.updates.string
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearNotifications()
    }
}

