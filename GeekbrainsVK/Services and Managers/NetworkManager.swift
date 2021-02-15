//
//  NetworkManager.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 15.02.2021.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - Private Fields
    
    private let session: Alamofire.Session = {
       
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    private let baseURL: String = "https://api.vk.com"
    
    // MARK: - Singleton instance
    
    static let shared = NetworkManager()
    
    // MARK: - Initialization
    
    private init() {
        
    }
    
    // MARK: - Get Requests
    
    func getFriends(count: Int? = nil) {
        
        let path = "/method/friends.get"
        
        var params: Parameters = [
            "access_token": Session.shared.token,
            "user_id": Session.shared.userId,
            "name_case": "city,domain",
            "order": "name",
            "fields": "city",
            "v": "5.92"
        ]
        
        if let count = count {
            params["count"] = count
        }
        
        session.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            
            guard let json = response.value else {
                return
            }
            
            print(json)
        }
    }
    
    func getPhotos() {
        
        
        
    }
    
    func getGroups(count: Int? = nil, userID: Int? = nil) {
        
        let path = "/method/groups.get"
        
        var params: Parameters = [
            "access_token": Session.shared.token,
            "extended": 1,
            "v": "5.92"
        ]
        
        if let count = count {
            params["count"] = count
        }
        
        if let userID = userID {
            params["user_id"] = userID
        }
        
        session.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            
            guard let json = response.value else {
                return
            }
            
            print(json)
        }
    }
    
}
