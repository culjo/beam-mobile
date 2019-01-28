//
//  UserProductsEndpoint.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation
import Alamofire

enum UserProductsEndpoint: ApiConfiguration {
    
    case fetch(userId: Int)
    case addToWatchList(productId: Int, userId: Int)
    
    var method: HTTPMethod {
        switch self {
        case .fetch:
            return .get
        case .addToWatchList:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .fetch(let userId):
            return "/users/\(userId)/products" // all user products
        case .addToWatchList(let productid, _):
            return "/products/\(productid)/subscribe"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetch(_):
            return nil
        case .addToWatchList(_, let userId):
            return ["userId" : userId]
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
