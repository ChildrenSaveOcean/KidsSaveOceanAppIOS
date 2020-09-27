//
//  WebIntegrationViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 2/8/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import WebKit
import Reachability

class WebIntegrationViewController: UIViewController {

    var hideNavigationBarByDefault: Bool { return webView.url?.host?.lowercased().hasPrefix("www.kidssaveocean.com") ?? false }
    var originalWebUrlString: String { return webUrlString }
    
    var webUrlString: String = "" {
        didSet(oldValue) {
            
            if webUrlString.isEmpty { return }
            if reachability == nil { return }
            
            let internetConnection = checkInternetConnection(reachability: reachability!)
            showInternetConnectionStatus(is: internetConnection)
            
            if internetConnection {
                loadPage()
            }
        }
    }
    
    private var reachability: Reachability? // = try Reachability()

    lazy var webView = { () -> WKWebView in
        let webConfiguration = WKWebViewConfiguration()
        let wV = WKWebView(frame: view.bounds, configuration: webConfiguration)
        wV.isOpaque = true
        wV.backgroundColor = .white
        wV.scrollView.bounces = false
        wV.clearsContextBeforeDrawing = true
        wV.loadHTMLString("", baseURL: nil)
        return wV
    }()

    lazy var progressBarView = { () -> UIProgressView in
        let pV = UIProgressView(progressViewStyle: .default)
        pV.tintColor = .kidsSaveOceanBlue
        let frame = navigationController?.navigationBar.frame ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        var y = max(frame.origin.y + frame.height, frame.height) //20)
        pV.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 5)
        return pV
    }()

    lazy var backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron-back"), style: .plain, target: self, action: #selector(goBack))
    lazy var forwardButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron"), style: .plain, target: self, action: #selector(goForward))

    lazy var noInternetConnectionImageView: UIImageView = { () -> UIImageView in
        let imageView = UIImageView(image: #imageLiteral(resourceName: "No Internet"))
        var frame = self.webView.frame
        if let newHeight = self.tabBarController?.tabBar.frame.height {
            frame.size.height -= newHeight
        }
        imageView.frame = frame
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        if reachability == nil {
            reachability = try? Reachability()
        }

        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability!.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }

        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false

        view.addSubview(webView)

        setNavigationButtons()
        navigationController?.setStatusBarColor(UIColor.white)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.navigationBar.isHidden = true
        setURLString(originalWebUrlString)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webUrlString = ""
    }

    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    // swiftlint:disable block_based_kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
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
    // swiftlint:enable block_based_kvo
    
    @objc func goBack() {
        if webView.canGoBack {
           webView.goBack()
        } else if canPopViewController() {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc func goForward() {
        webView.goForward()
    }
    
    func checkNavigationButtons() {
        navigationController?.navigationBar.isHidden = hideNavigationBarByDefault

        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        var canGoBack = webView.canGoBack
        if !canGoBack {
            canGoBack = canPopViewController()
        }
        backButton.isEnabled = canGoBack ? true : false
        forwardButton.isEnabled =  webView.canGoForward ? true : false
    }

    private func canPopViewController() -> Bool {
        return (webView.canGoBack == true) || (navigationController?.viewControllers.first != self)
    }

    private func checkInternetConnection(reachability: Reachability) -> Bool {
        return reachability.connection != .unavailable
    }
    
    private func showInternetConnectionStatus(is on: Bool) {
        if on {
            if view.contains(noInternetConnectionImageView) {
                noInternetConnectionImageView.removeFromSuperview()
                backButton.isEnabled = true
            }
        } else {
            navigationController?.navigationBar.isHidden = false
            view.addSubview(noInternetConnectionImageView)
            backButton.isEnabled = false
        }
        return
    }

    private final func loadPage() {
        
        view.addSubview(progressBarView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        checkURLString()
        let myURL = URL(string: webUrlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    func checkURLString() {
        if webUrlString.isEmpty {
            fatalError("Set the URL string up!")
        }
    }

    func setURLString(_ string: String) {
        self.webUrlString = ""
        self.webUrlString = string
    }
    
    @objc func reachabilityChanged(note: Notification) {
        // unfortunately the notification about changing reachability does not came when the internet connection has been changed. That is why I temporary commented the behaviour.
        
//        guard let noteObject = note.object as? Reachability else {return}
//        if reachability?.connection != noteObject.connection && checkInternetConnection(reachability: noteObject) {
//            loadPage()
//        }
    }
    
    func refreshView() {
        setURLString(originalWebUrlString)
    }
    
    func setNavigationButtons() {
        backButton.isEnabled = false
        navigationItem.leftBarButtonItem = backButton
        forwardButton.isEnabled = false
        navigationItem.rightBarButtonItem = forwardButton
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
        //let title = (webView.title ?? "").contains("|") ? String((webView.title?.split(separator: "|").last)!): webView.title
        //navigationItem.title = title
        checkNavigationButtons()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        checkNavigationButtons()
    }
}
