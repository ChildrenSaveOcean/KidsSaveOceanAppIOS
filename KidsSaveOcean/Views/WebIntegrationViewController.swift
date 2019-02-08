//
//  WebIntegrationViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit

class WebIntegrationViewController: UIViewController {
    
    var webUrlString: String { return "" }
    
    lazy var webView = { () -> WKWebView in
        let webConfiguration = WKWebViewConfiguration()
        let wV = WKWebView(frame: view.bounds, configuration: webConfiguration)
        return wV
    }()
    
    lazy var progressBarView = { () -> UIProgressView in
        let pV = UIProgressView(progressViewStyle: .default)
        let height = (navigationController?.navigationBar.bounds.height)! + (navigationController?.navigationBar.frame.origin.y)!
        pV.frame = CGRect(x:0, y:height, width:view.bounds.width, height:5)
        return pV
    }()
    
    lazy var backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron-back"), style: .plain, target: self, action: #selector(goBack))
    lazy var forwardButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron"), style: .plain, target: self, action: #selector(goForward))
    
    //override func loadView() {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.frame = view.bounds
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        //view = webView
        
        view.addSubview(webView)
        view.addSubview(progressBarView)
        
        backButton.isEnabled = false
        navigationItem.leftBarButtonItem = backButton
        forwardButton.isEnabled = false
        navigationItem.rightBarButtonItem = forwardButton
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let myURL = URL(string:webUrlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView.estimatedProgress)
            if progress < 1 {
                progressBarView.alpha = 1
                progressBarView.progress = Float(webView.estimatedProgress)
            } else {
                progressBarView.alpha = 0
                progressBarView.progress = 0
            }
        }
    }
    
    @objc func goBack() {
        webView.goBack()
    }
    
    @objc func goForward() {
        webView.goForward()
    }
    
}

extension WebIntegrationViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

extension WebIntegrationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.title = String((webView.title?.split(separator: "|").last)!)
        checkNavigationButtons()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        checkNavigationButtons()
    }
    
    func checkNavigationButtons() {
        backButton.isEnabled =  webView.canGoBack ? true : false
        forwardButton.isEnabled =  webView.canGoForward ? true : false
    }
}

