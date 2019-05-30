//
//  MediaViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class MediaViewController: WebIntegrationViewController {

    override func loadPage() {
        self.webUrlString = "https://www.kidssaveocean.com/updates"
        super.loadPage()
    }
}
