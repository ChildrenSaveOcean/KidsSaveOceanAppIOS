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
        guard let navigationController = getNavigationController() else {return}
        let alertViewController = AlertActionDashboardViewController()
        navigationController.pushViewController(alertViewController, animated: true)
    }
    
    func switchToResourcesScreen() {
        self.selectedIndex = 3
    }
    
    func switchToStudentResourcesScreen() {
        switchToResourcesScreen()
        let navigationController = getNavigationController()
        if let resources = navigationController?.viewControllers.first as? ResourcesViewController {
            resources.webUrlString = "https://www.kidssaveocean.com/studentresources"
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
    
    func showLink(_ link: String) {
        let navigationController = getNavigationController()
        let webPageVC = WebIntegrationViewController()
        webPageVC.webUrlString = link
        navigationController?.pushViewController(webPageVC, animated: true)
    }
    
    func refreshSelectedTab() {
        guard let selectedViewController = getSelectedTabMainViewController() else {return}
        getNavigationController()?.popToViewController(selectedViewController, animated: true)
    }
    
    private func getNavigationController() -> UINavigationController? {
        return self.selectedViewController as? UINavigationController
    }
    
    private func getMapViewController() -> MapViewController? {
        self.selectedIndex = 4
        return getSelectedTabMainViewController()
    }
    
}
