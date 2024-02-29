//
//  NoticeWebViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/21/24.
//

import UIKit
import WebKit

class NoticeWebViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setNavigationController()
        loadWebView()
    }
    
    // MARK: - Methods
    private func setView() {
        view.backgroundColor = HexColor.from("#2d324e")
    }
    
    private func setNavigationController() {
        navigationController?.navigationBar.barTintColor = HexColor.from("#2d324e")
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func loadWebView() {
        let webViewManager = WebViewManager()
        
        webViewManager.setViewAndAutoLayout(view)
        webViewManager.loadURL("http://bus.yangsan.go.kr/yangsan_2016/yangsan_mobile/info_use/noticeList.php")
    }
}

extension NoticeWebViewController: WKUIDelegate {
    
}
