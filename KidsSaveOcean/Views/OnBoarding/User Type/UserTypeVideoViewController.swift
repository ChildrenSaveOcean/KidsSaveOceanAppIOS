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
    
    override var originalWebUrlString: String {
        guard !urlString.isEmpty else { return "" }
        //return "https://youtu.be/5S0_1YJV064"
        //return "https://www.youtube.com/embed/5S0_1YJV064"
        switch userType {
        case .student:
             return "https://www.kidssaveocean.com/video-test"
        default:
            return "https://www.youtube.com/embed/5S0_1YJV064"
            //"https://youtu.be/TueclrttB1o"
        }
    }

    private func showActionButtons() {
        let buttonsWidth: CGFloat = 50
        let buttonsHeight: CGFloat = 50
        let shiftY = self.view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - buttonsHeight - 10
        let shiftX = (self.view.bounds.width - 2*buttonsWidth)/3

        let backButton = self.createButtonWithTitle(.back)
        backButton.frame = CGRect(x: shiftX, y: shiftY, width: buttonsWidth, height: buttonsHeight)

        backButton.addTargetClosure { (_) in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
        webView.addSubview(backButton)
        webView.bringSubviewToFront(backButton)
        
        let goButton = self.createButtonWithTitle(.forward)
        goButton.frame = CGRect(x: self.view.bounds.width - buttonsWidth - shiftX, y: shiftY, width: buttonsWidth, height: buttonsHeight)

        goButton.addTargetClosure { (_) in
            UserDefaultsHelper.saveOnBoardingHasBeenShown()

            if self.userType != nil {
                let userViewModel = UserViewModel.shared()
                userViewModel.user_type = self.userType!
                userViewModel.saveUser()
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
        let image = direction == .back ? #imageLiteral(resourceName: "Back_video") : #imageLiteral(resourceName: "skip_video")
        button.setImage(image, for: .normal)
        return button
    }

    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        showActionButtons()
    }
}
