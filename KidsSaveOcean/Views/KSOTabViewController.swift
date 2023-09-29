//
//  KSOTabViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/6/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOTabViewController: UITabBarController, Instantiatable {
}

extension UITabBarController {
    
    func switchToHomeScreen() {
        self.selectedIndex = 0
    }
    
    func switchToNewsAndMediaScreen() {
        self.selectedIndex = 1
    }
    
    func switchToDashboardScreen() {
        self.selectedIndex = 2
    }
    
    func switchToActionAlertScreen() {
        self.selectedIndex = 2
        let alertActionVC = AlertActionDashboardViewController()
        present(alertActionVC, animated: true) {
            self.updateNotificationStatusOfSelectedViewController()
        }
    }
    
    func switchToResourcesScreen() {
        self.selectedIndex = 3
    }
    
    func switchToStudentResourcesScreen() {
        switchToResourcesScreen()
        if let resources = getSelectedTabMainViewController() as? ResourcesViewController {
            resources.webUrlString = ServerPath.studentresources.string
        }
    }
    
    func switchToCountryContactsScreen() {
        guard let navigationController = getNavigationController() else {return}
        navigationController.pushViewController(CountryContactsViewController.instantiate(), animated: true)
    }
    
    func switchToMapScreen() {
        getMapViewController()?.segmentControlDefaultIndex = 0
    }
    
    func switchToHighScoreScreen() {
        getMapViewController()?.segmentControlDefaultIndex = 1
    }
    
    func getSelectedTabMainViewController<T: UIViewController>() -> T? {
        return (self.selectedViewController as? UINavigationController)?.viewControllers.first as? T
    }
    
    func showLink(_ link: String, clear target: NotificationTarget?) {
        
        switchToHomeScreen()
        let webViewController = ShowLinkWithClearNotificatinStatusViewController()
        webViewController.webUrlString = link
        guard let navigationController = getNavigationController() else {return}
        navigationController.pushViewController(webViewController, animated: true)
        if target != nil {
            webViewController.clearNotificationForTarget(target!)
        }
    }
    
    func refreshSelectedTab() {
        guard let selectedViewController = getSelectedTabMainViewController() else {return}
        getNavigationController()?.popToViewController(selectedViewController, animated: true)
    }
    
    func updateNotificationStatusOfSelectedViewController() {
        guard let selectedViewController = getSelectedTabMainViewController() as? NotificationProtocol else {return}
        selectedViewController.updateViews()
    }
    
    private func getNavigationController() -> UINavigationController? {
        return self.selectedViewController as? UINavigationController
    }
    
    private func getMapViewController() -> MapViewController? {
        self.selectedIndex = 4
        return getSelectedTabMainViewController()
    }
    
}
