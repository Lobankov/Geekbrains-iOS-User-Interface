//
//  VKConstants.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 15.02.2021.
//

import Foundation

enum VKConstants: String {
    
    case appID = "7762734"
}

enum VKAccessRightsBitMask: Int {
    
    case notify         = 1
    case friends        = 2
    case photos         = 4
    case audio          = 8
    case video          = 16
    case stories        = 64
    case pages          = 128
    case appURL         = 256
    case status         = 1024
    case notes          = 2048
    case messages       = 4096
    case wall           = 8192
    case ads            = 32768
    case offline        = 65536
    case docs           = 131072
    case groups         = 262144
    case notifications  = 524288
    case stats          = 1048576
    case email          = 4194304
    case market         = 134217728
    
    var value: UInt8 {
        return UInt8(1 << self.rawValue)
    }
}
