//
//  Session.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 12.02.2021.
//

import Foundation

/// Singleton that stores information about current session in vk.com
/// - Note: Thread safe
/// - Tag: Session
final class Session {
    
    // MARK: - Private Fields
    
    private var _token  : String
    private var _userId : Int
    
    /// DispatchQueue that is responsible for thread safety
    private let sessionDispatchQueue = DispatchQueue(label: "com.singletonsession.geekbrainsvk.queue", qos: .default, attributes: .concurrent)
    
    
    // MARK: - Internal Properties
    
    /// Bearer token of a user logged via vk.com API
    /// - Tag: Session.token
    var token   : String {
        get {
            return sessionDispatchQueue.sync {
                _token
            }
        }
        set {
            sessionDispatchQueue.async(flags: .barrier) {
                self._token = newValue
            }
        }
    }
    
    /// Current user identifier
    /// - Tag: Session.userId
    var userId  : Int {
        get {
            return sessionDispatchQueue.sync {
                _userId
            }
        }
        set {
            sessionDispatchQueue.async(flags: .barrier) {
                self._userId = newValue
            }
        }
    }
    
    // MARK: - Singleton instance
    
    static let shared = Session()
    
    // MARK: - Initialization
    
    private init() {
        self._token = String()
        self._userId = 0
    }
    
}
