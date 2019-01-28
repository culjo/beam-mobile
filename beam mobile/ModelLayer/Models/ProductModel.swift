//
//  ProductModel.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

//typealias Products = [Product]

class Products: Codable {
    let start, perPage, total: Int
    let data: [Product]
    
    enum CodingKeys: String, CodingKey {
        case start
        case perPage = "per_page"
        case total
//        case totalPages = "total_pages"
        case data
    }
}

class Product: Codable {
    let productID: Int
    let name, slug, price, discount: String
    let priceToSubtract: String
    let stockCount: Int
    let isPromoEnabled: Bool
    let category, manufacturer, image, description: String
    let specifications, tags, createdOn, updatedOn: String
    
    //The bellow field are ignored from codable
    var isInUserFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case name, slug, price, discount
        case priceToSubtract = "price_to_subtract"
        case stockCount = "stock_count"
        case isPromoEnabled = "is_promo_enabled"
        case category, manufacturer, image, description, specifications, tags
        case createdOn = "created_on"
        case updatedOn = "updated_on"
    }
}
