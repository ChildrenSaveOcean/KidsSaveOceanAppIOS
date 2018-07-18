//
//  KSOUserTypeViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class KSOUserTypeViewController: KSOBaseViewController, UIWebViewDelegate  {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.gray)
    let webView = UIWebView()
    
    override func viewDidLoad() {
        subViewsData = KSOUserTypeViewData
        super.viewDidLoad()
    }
    
    
    // TODO:
    // - move all about webView to its own class extention if it will be used later in another VC
    // - errors message -> Error handler
    // - why it is loading so slow?
    
    override func touchView(_ actionString: String) {
        
        if Reachability.isConnectedToNetwork() == true {
            self.showVideo(actionString)
        } else {
            self.errorMessage("No Internet Connection.\nYou can go ahead without introducing video or try again", actionString: actionString)
        }
    }
    
    
    fileprivate func showVideo(_ videoAddressString:String) {
        
        webView.frame = view.bounds
        webView.delegate = self
        
        view.addSubview(webView)
        view.bringSubview(toFront: webView)
        
       guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoAddressString)")
            else {
                self.errorMessage("Something goes wrong with video you've choosen.\nYou can go ahead without introducing video or try again", actionString: videoAddressString)
                return
            }
        
         webView.loadRequest( URLRequest(url: youtubeURL) )
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.frame = CGRect(x:view.bounds.width/2, y:view.bounds.height/2, width:30, height:30)
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        videoHasBeenLoaded()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
       videoHasBeenLoaded()
    }
    
    fileprivate func videoHasBeenLoaded() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        showActionButtons()
    }
    
    fileprivate func showActionButtons() {
        
        let buttonsWidth:CGFloat = 100
        let buttonsHeight:CGFloat = 50
        let shiftY = self.view.bounds.height - 90
        let shiftX = (self.view.bounds.width - 2*buttonsWidth)/3
        
        let goButton = self.createButtonWithTitle("Go ahead")
        goButton.frame = CGRect(x: shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
        
        goButton.addTargetClosure { (sender) in
            Settings.saveOnBoardingHasBeenShown()
            self.gotoTabViewController()
        }
        
        webView.addSubview(goButton)
        webView.bringSubview(toFront: goButton)
        
        let backButton = self.createButtonWithTitle("Back")
        backButton.frame = CGRect(x: self.view.bounds.width - buttonsWidth - shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
        
        backButton.addTargetClosure { (sender) in
            self.webView.stopLoading()
            self.webView.removeFromSuperview()
        }
        
        webView.addSubview(backButton)
        webView.bringSubview(toFront: backButton)
    }
    
    fileprivate func createButtonWithTitle(_ title:String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .black
        button.roundCorners()
        return button
    }
    
    fileprivate func gotoTabViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
        self.present(tabViewController, animated: true, completion: nil)
    }
    
    fileprivate func errorMessage(_ message:String, actionString:String) {
        
        let warnMessage = UIAlertController(title: "Warning",
                                            message: message,
                                            preferredStyle: .alert)
        
        let tryAgainButton = UIAlertAction(title: "Cancel and Try again", style: .cancel) { (action:UIAlertAction) in
            //self.touchView(actionString)
        }
        
        let goAheadButton = UIAlertAction(title: "Go ahead", style: .default) { (action:UIAlertAction) in
            self.gotoTabViewController()
        }
        warnMessage.addAction(goAheadButton)
        warnMessage.addAction(tryAgainButton)
        
        self.present(warnMessage, animated: true, completion: nil)
    }
}
