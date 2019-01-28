//
//  UserProductModel.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct UserProducts: Codable {
    let success: Bool // TODO: Remove Please
    let message: String
    let data: [UserProduct]
}

struct UserProduct: Codable {
    let userProductID, userID, productID: Int
    let myPrice: String
    let disabled: Bool
    let createdOn, updatedOn: String
    let product: Product
    
    enum CodingKeys: String, CodingKey {
        case userProductID = "user_product_id"
        case userID = "user_id"
        case productID = "product_id"
        case myPrice = "my_price"
        case disabled
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case product
    }
}

