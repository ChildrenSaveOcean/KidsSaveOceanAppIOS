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

    var webUrlString: String = ""
    private var reachability = Reachability()

    lazy var webView = { () -> WKWebView in
        let webConfiguration = WKWebViewConfiguration()
        let wV = WKWebView(frame: view.bounds, configuration: webConfiguration)
        wV.isOpaque = false
        wV.backgroundColor = .clear
        return wV
    }()

    lazy var progressBarView = { () -> UIProgressView in
        let pV = UIProgressView(progressViewStyle: .default)

        let y = (navigationController?.navigationBar.frame.origin.y)! + ((navigationController?.navigationBar.isHidden)! ? 0 : (navigationController?.navigationBar.bounds.height)!)
        pV.frame = CGRect(x: 0, y: y, width: view.bounds.width, height: 5)
        return pV
    }()

    lazy var backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron-back"), style: .plain, target: self, action: #selector(goBack))
    lazy var forwardButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron"), style: .plain, target: self, action: #selector(goForward))

    lazy var noInternetConnectionImageView = UIImageView(image: #imageLiteral(resourceName: "No Internet"))

    override func viewDidLoad() {

        super.viewDidLoad()

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

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear

        //backButton.isEnabled = false
        navigationItem.leftBarButtonItem = backButton
        forwardButton.isEnabled = false
        navigationItem.rightBarButtonItem = forwardButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if checkInternetConnection(reachability: reachability!) {
            loadPage()/////
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webUrlString = ""
    }

    deinit {
        reachability!.stopNotifier()
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

    private func canPopViewController() -> Bool {
        return  (navigationController?.viewControllers.first != self)
    }

    private func checkInternetConnection(reachability: Reachability) -> Bool {
        if reachability.connection == .none {
            showNoInternetConnection()
            return false
        } else {
            noInternetConnectionImageView.removeFromSuperview()
            return true
        }
    }

    private func showNoInternetConnection() {
        navigationController?.navigationBar.isHidden = false
        webView.addSubview(noInternetConnectionImageView)
        return
    }

    func loadPage() {
        view.addSubview(progressBarView)

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        checkURLString()
        let myURL = URL(string: webUrlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    func checkURLString() {
        if webUrlString.count == 0 {
            fatalError("Set the URL string up!")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        guard let noteObject = note.object as? Reachability else {return}
        checkInternetConnection(reachability: noteObject)
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
        let title = (webView.title ?? "").contains("|") ? String((webView.title?.split(separator: "|").last)!): webView.title
        navigationItem.title = title
        checkNavigationButtons()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        checkNavigationButtons()
    }

    func checkNavigationButtons() {
        var canGoBack = webView.canGoBack
        if !canGoBack {
            canGoBack = canPopViewController()
        }
        backButton.isEnabled = canGoBack ? true : false
        forwardButton.isEnabled =  webView.canGoForward ? true : false
    }
}
