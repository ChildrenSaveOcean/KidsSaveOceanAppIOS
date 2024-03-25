//
//  ResourcesViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit

class ResourcesViewController: WebIntegrationViewController {

    override var hideNavigationBarByDefault: Bool { return true }

    override var originalWebUrlString: String {
        return ServerPath.fatechanger_resources.string
    }
}
