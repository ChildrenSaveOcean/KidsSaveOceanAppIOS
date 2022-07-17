//
//  UserTypeVideoViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit

protocol UserTypeVideoDelegate: AnyObject {
    func showErrorMessage(_ message: String, actionString: String)
    func gotoTabViewController()
}

class UserTypeVideoViewController: WebIntegrationViewController {
    
    enum ButtonDirectionType {
        case back, forward
    }

    weak var delegate: UserTypeVideoDelegate?
    var urlString: String = ""
    var userType: UserType?
    
    private let buttonWidth: CGFloat = 50
    private let buttonHeight: CGFloat = 50
    
    override var originalWebUrlString: String {
        guard !urlString.isEmpty else { return "" }
        switch userType {
        case .student:
             return "https://www.kidssaveocean.com/fatechangeryouthintro"
        default:
            return "https://www.kidssaveocean.com/video-test"
        }
    }

    private func showActionButtons() {

        let shiftY = self.view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - buttonHeight - 10
        let shiftX = (self.view.bounds.width - 2*buttonWidth)/3

        let backButton = self.createButtonWithTitle(.back)
        backButton.frame = CGRect(x: shiftX, y: shiftY, width: buttonWidth, height: buttonHeight)

        backButton.addTargetClosure { (_) in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
        webView.addSubview(backButton)
        webView.bringSubviewToFront(backButton)
        
        let goButton = self.createButtonWithTitle(.forward)
        goButton.frame = CGRect(x: self.view.bounds.width - buttonWidth - shiftX, y: shiftY, width: buttonWidth, height: buttonHeight)

        goButton.addTargetClosure { _ in
            UserDefaultsHelper.saveOnBoardingHasBeenShown()

            if let userType = self.userType {
                User.shared.userType = userType
                User.shared.save()
            }

            let tabBarController = KSOTabViewController.instantiate()
            UIApplication.shared.keyWindow?.rootViewController = tabBarController
            self.present(tabBarController, animated: true, completion: nil)
        }
        webView.addSubview(goButton)
        webView.bringSubviewToFront(goButton)

    }

    private func createButtonWithTitle(_ direction: ButtonDirectionType) -> UIButton {

        let button = UIButton()
        let image = direction == .back ?  #imageLiteral(resourceName: "chevron-back") : #imageLiteral(resourceName: "chevron")
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.kidsSaveOceanBlue
        button.layer.cornerRadius = buttonWidth/2
        button.clipsToBounds = true
        return button
    }

    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        showActionButtons()
    }
}
