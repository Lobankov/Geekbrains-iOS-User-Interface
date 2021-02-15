//
//  LoginWebViewVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 15.02.2021.
//

import UIKit
import WebKit

final class LoginWebViewVC: UIViewController {
    
    // MARK: - UI Components
    
    private var webView: WKWebView!
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        webView = WKWebView();
        self.view = webView
        
        webView.navigationDelegate = self
    }
    
    // MARK: - Layout
    
    private func setupWebView() {
        
        
    }
}

extension LoginWebViewVC: WKNavigationDelegate {
    
    
    
}
