//
//  ApiConfiguration.swift
//  trudata
//
//  Created by MAC on 1/19/19.
//  Copyright © 2019 trudata. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
