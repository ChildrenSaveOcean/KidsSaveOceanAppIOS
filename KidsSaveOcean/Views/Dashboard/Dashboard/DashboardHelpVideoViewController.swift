//
//  DashboardHelpVideoViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/26/20.
//  Copyright © 2020 KidsSaveOcean. All rights reserved.
//

import UIKit

class DashboardHelpVideoViewController: WebIntegrationViewController {

    override var hideNavigationBarByDefault: Bool { return false }

    override var originalWebUrlString: String {
        return ServerPath.dashboardtutorial.string
    }

}
