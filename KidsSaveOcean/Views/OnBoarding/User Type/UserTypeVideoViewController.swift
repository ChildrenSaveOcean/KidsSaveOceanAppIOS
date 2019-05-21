//
//  UserTypeVideoViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit

protocol UserTypeVideoDelegate {
    func showErrorMessage(_ message: String, actionString: String)
    func gotoTabViewController()
}

class UserTypeVideoViewController: WebIntegrationViewController {

    var delegate: UserTypeVideoDelegate?
    var urlString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webUrlString = "https://www.youtube.com/embed/\(urlString)"
    }

    var userType: UserType?

    private func showActionButtons() {
        let buttonsWidth: CGFloat = 100
        let buttonsHeight: CGFloat = 50
        let shiftY = self.view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - buttonsHeight - 10
        let shiftX = (self.view.bounds.width - 2*buttonsWidth)/3

        let goButton = self.createButtonWithTitle("GO AHEAD")
        goButton.frame = CGRect(x: shiftX, y: shiftY, width: buttonsWidth, height: buttonsHeight)

        goButton.addTargetClosure { (_) in
            Settings.saveOnBoardingHasBeenShown()

            if self.userType != nil {
                let userViewModel = UserViewModel.shared()
                userViewModel.user_type = self.userType!
                userViewModel.saveUser()
            }

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
            self.present(tabViewController, animated: true, completion: nil)
        }
        webView.addSubview(goButton)
        webView.bringSubviewToFront(goButton)

        let backButton = self.createButtonWithTitle("BACK")
        backButton.frame = CGRect(x: self.view.bounds.width - buttonsWidth - shiftX, y: shiftY, width: buttonsWidth, height: buttonsHeight)

        backButton.addTargetClosure { (_) in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
        webView.addSubview(backButton)
        webView.bringSubviewToFront(backButton)
    }

    private func createButtonWithTitle(_ title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .black
        button.roundCorners()
        return button
    }

    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        showActionButtons()
    }
}
