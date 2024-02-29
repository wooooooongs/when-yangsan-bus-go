//
//  WebViewManager.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/21/24.
//

import UIKit
import WebKit

struct WebViewManager {
    var webView: WKWebView
    
    init() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
    func setViewAndAutoLayout(_ view: UIView) {
        view.addSubview(webView)

        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func loadURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func scrollViewDidScroll() {
        if webView.scrollView.contentOffset.x >  0 {
            webView.scrollView.contentOffset = CGPoint(x:  0, y: webView.scrollView.contentOffset.y)
        }
    }
}
