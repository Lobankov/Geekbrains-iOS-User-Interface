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
            "v": "5.92",
            "user_id": Session.shared.userId,
            "name_case": "city,domain",
            "order": "name",
            "fields": "city",
        ]
        
        if let count = count {
            params["count"] = count
        }
        
        session.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            
            guard let json = response.value else {
                return
            }
            print("-------- FRIENDS --------")
            print(json)
        }
    }
    
    func getPhotos() {
        
        let path = "/method.photos.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.92",
            "owner_id": Session.shared.userId,
            "album_id": "profile",
            "extended": 1
        ]
        
        session.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            
            guard let json = response.value else {
                return
            }
            print("-------- PHOTOS --------")
            print(json)
        }
    }
    
    func getGroups(count: Int? = nil, userID: Int? = nil) {
        
        let path = "/method/groups.get"
        
        var params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.92",
            "extended": 1,
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
            print("-------- GROUPS --------")
            print(json)
        }
    }
    
    func searchGroups(with searchString: String) {
        
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.92",
            "q": searchString
        ]
        
        session.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            
            guard let json = response.value else {
                return
            }
            
            print("-------- GROUPS SEARCH --------")
            print(json)
        }
    }
}
