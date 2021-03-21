//
//  WebViewController.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var webView: WKWebView!
    var webLink: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Source"
        self.setCustomBackButton(withNav: self.navigationItem, withImage: "customBackButton", actionSelector: #selector(self.backAction(_:)), buttonWidth: 35, buttonHeight: 35)
        self.startWebUrl()
    }
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            self.webView.navigationDelegate = self
            view = webView
        }
    
    func startWebUrl() {
        if let webUrl = URL(string: self.webLink!) {
            webView.load(URLRequest(url: webUrl))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
}

extension WebViewController: WKUIDelegate,WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ProgressView.present(animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        ProgressView.dismiss(animated: true)
        decisionHandler(.allow)
    }
}
