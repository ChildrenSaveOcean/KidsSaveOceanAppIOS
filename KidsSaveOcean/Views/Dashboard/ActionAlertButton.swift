//
//  ActionAlertButton.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

protocol ActionAlertProtocol: NSObject {
    func showActionAlertView()
    func gotoActionAlertViewController()
}

enum ActionAlertState {
    case active, inactive
}

class ActionAlertButton: UIButton, NotificationProtocol {
    weak var delegate: ActionAlertProtocol?
    
    var actionAlertState: ActionAlertState = .inactive {
        willSet(newValue) {
            if newValue == .active { 
                self.setImage(#imageLiteral(resourceName: "ACTION ALERT LIVE"), for: .normal)
                self.addTarget(self, action: #selector(activeAction), for: .touchUpInside)
            } else {
                self.setImage(#imageLiteral(resourceName: "ACTION ALERT"), for: .normal)
                self.addTarget(self, action: #selector(inactiveAction), for: .touchUpInside)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilaze()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilaze()
    }
    
    private func initilaze() {
        actionAlertState = (isNotificationActualForTarget(NotificationTarget.actionAlert) == true) ? .active : .inactive
    }
    
    @objc func activeAction() {
        delegate?.gotoActionAlertViewController()
    }
    
    @objc private func inactiveAction() {
        delegate?.showActionAlertView()
    }
    
}
