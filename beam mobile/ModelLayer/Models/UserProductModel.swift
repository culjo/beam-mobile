//
//  UserProductModel.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct UserProductResponse: Codable {
    let success: Bool
    let message: String
    let data: UserProduct
}

struct UserProduct: Codable {
    let userProductID: Int
    let productID: Int
    let userID: Int
    let myPrice: String
    let updatedOn, createdOn: String
    
    enum CodingKeys: String, CodingKey {
        case userProductID = "user_product_id"
        case productID = "product_id"
        case userID = "user_id"
        case myPrice = "my_price"
        case updatedOn = "updated_on"
        case createdOn = "created_on"
    }
}
