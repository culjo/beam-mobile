//
//  UrlConstants.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct UrlConstants {
    
    static let baseUrl = "http://192.168.0.157:3002"
    
    // The parameters (Queries)
    struct APIParameterKey {
        static let userId = "userId"
        static let email = "email"
        static let password = "password"
    }
    
    // The header fields
    enum HTTPHeaderField: String {
        case authenitication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        
    }
    
    // the content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
