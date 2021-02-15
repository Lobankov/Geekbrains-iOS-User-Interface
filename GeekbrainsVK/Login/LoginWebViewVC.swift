//
//  LoginWebViewVC.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 15.02.2021.
//

import UIKit
import WebKit
import Alamofire

final class LoginWebViewVC: UIViewController {
    
    // MARK: - Constants
    
    private let appID = "7762734"
    
    
    // MARK: - UI Components
    
    private var webView: WKWebView!
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = UIView()
        webView = WKWebView();
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.fill(view)
        
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        requestAuthorization()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthorization()
    }
    
    // MARK: - Helpers
    
    private func requestAuthorization() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        
        let requiredAccess = VKAccessRightsBitMask.friends.rawValue + VKAccessRightsBitMask.photos.rawValue + VKAccessRightsBitMask.groups.rawValue
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: appID),
            URLQueryItem(name: "scope", value: String(requiredAccess)),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        guard let url = components.url else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Layout
    
    private func setupWebView() {
        
        
    }
}

extension LoginWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce([String: String]()) { result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            
            return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let userId = Int(userIdString) else {
            return
        }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
//        NetworkManager.shared.getGroups(count: 5, userID: Session.shared.userId)
        NetworkManager.shared.getFriends(count: 10)
        
        decisionHandler(.cancel)
    }
    
}
