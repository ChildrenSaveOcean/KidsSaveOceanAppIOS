//
//  UserTypeVideoViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/20/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

protocol UserTypeVideoDelegate {
    func showErrorMessage(_ message:String, actionString:String)
    func gotoTabViewController()
}

class UserTypeVideoViewController: UIViewController {
    
    var delegate:UserTypeVideoDelegate?
    var urlString:String = ""
    let webView = UIWebView()
    let activityIndicator = UIActivityIndicatorView(style:.gray)
    
    override func viewDidLoad() {
        webView.frame = view.bounds
        webView.delegate = self as UIWebViewDelegate
        
        view.addSubview(webView)
        
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(urlString)")
            else {
                self.delegate?.showErrorMessage("Something goes wrong with video you've choosen.\nYou can go ahead without introducing video or try again", actionString: urlString)
                return
        }
        
        webView.loadRequest( URLRequest(url: youtubeURL) )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    private func showActionButtons() {
        let buttonsWidth:CGFloat = 100
        let buttonsHeight:CGFloat = 50
        let shiftY = self.view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - buttonsHeight - 10
        let shiftX = (self.view.bounds.width - 2*buttonsWidth)/3
        
        let goButton = self.createButtonWithTitle("GO AHEAD")
        goButton.frame = CGRect(x: shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
        
        goButton.addTargetClosure { (sender) in
            Settings.saveOnBoardingHasBeenShown()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
            self.present(tabViewController, animated: true, completion: nil)
        }
        webView.addSubview(goButton)
        webView.bringSubviewToFront(goButton)
        
        let backButton = self.createButtonWithTitle("BACK")
        backButton.frame = CGRect(x: self.view.bounds.width - buttonsWidth - shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
        
        backButton.addTargetClosure { (sender) in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
            self.navigationController?.popToRootViewController(animated: true)
        }
        webView.addSubview(backButton)
        webView.bringSubviewToFront(backButton)
    }
    
    private func createButtonWithTitle(_ title:String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .black
        button.roundCorners()
        return button
    }
    
    private func videoIsLoaded() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        showActionButtons()
    }
}

// MARK: UIWebViewDelegate
extension UserTypeVideoViewController:UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        //
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        videoIsLoaded()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        videoIsLoaded()
    }
}
