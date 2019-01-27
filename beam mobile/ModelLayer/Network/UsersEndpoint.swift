//
//  UsersEndpoint.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation
import Alamofire

enum UsersEndpoint: ApiConfiguration {
    
    case login(phone: String, uniqueId: String )
    case saveFcmToken(userId: Int, token: String)
    
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .saveFcmToken:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .saveFcmToken:
            return "/users/saveToken"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let phone, let uniqueId):
            return ["phone": phone, "uniqueId": uniqueId]
        case .saveFcmToken(let userId, let token):
            return ["userId" : userId, "token": token]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try UrlConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue //
        
        // set common headers
        urlRequest.setValue(UrlConstants.ContentType.json.rawValue, forHTTPHeaderField: UrlConstants.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(UrlConstants.ContentType.json.rawValue, forHTTPHeaderField: UrlConstants.HTTPHeaderField.contentType.rawValue)
        
        let encoding: ParameterEncoding = {
            switch method {
            case .post, .put:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
