//
//  HijackPolicyVideoViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/19/20.
//  Copyright © 2020 KidsSaveOcean. All rights reserved.
//

import UIKit

class HijackPolicyVideoViewController: WebIntegrationViewController, Instantiatable {

    override var hideNavigationBarByDefault: Bool { return false }
    
    override var originalWebUrlString: String {
        return ServerPath.hijackpolicy.string
    }
}
