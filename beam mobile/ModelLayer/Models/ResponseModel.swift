//
//  ResponseModel.swift
//  beam mobile
//
//  Created by MAC on 1/29/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let success: Bool
    let message: String
    let data: JSONNull?
    
}

struct ResponseUpdate: Codable {
    let success: Bool
    let message: String
    let data: UpdatedResult
}

struct UpdatedResult: Codable {
    let updated: [Int]
}

// MARK: Encode/decode helpers

/*class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}*/
