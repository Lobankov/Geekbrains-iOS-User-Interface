//
//  StringExtensions.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 07.12.2020.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        
        let emailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let regex = try! NSRegularExpression(pattern: emailPattern, options: .caseInsensitive)
        
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPhoneNumber() -> Bool {
        
        let phonePattern = "(?:(\\+\\d\\d\\s+)?((?:\\(\\d\\d\\)|\\d\\d)\\s+)?)(\\d{4,5}\\-?\\d{4})"
        
        let regex = try! NSRegularExpression(pattern: phonePattern, options: [])
        
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
}
