//
//  WebViewViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class WebViewViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var WebView: UIWebView!
    
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        WebView?.delegate = self
        loadWebView(url: url)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnBack.layer.cornerRadius = 6
        makeRounded(view: btnBack)
    }
    
    func loadWebView(url: String) {
        if url != "" {
            WebView.scalesPageToFit = true
            let url = URL (string: url)
            let requestObj = URLRequest(url: url!)
            WebView.scrollView.minimumZoomScale = 1.0;
            WebView.scrollView.maximumZoomScale = 1.0;
            WebView.loadRequest(requestObj)
        }
    }
    
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WebViewViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        showLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
