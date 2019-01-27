//
//  UserModel.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let success: Bool
    let message: String
    let data: User
}

struct User: Codable {
    let userID: Int
    let uniqueID, deviceFcmToken: String
    let name: JSONNull?
    let phone: String
    let location: JSONNull?
    let createdOn, updatedOn: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case uniqueID = "unique_id"
        case deviceFcmToken = "device_fcm_token"
        case name, phone, location
        case createdOn = "created_on"
        case updatedOn = "updated_on"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
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
}
