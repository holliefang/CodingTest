//
//  Data.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/16.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import Foundation

struct Result: Codable {
    var count: Int
    var data: [Data]
    var max: Int
    var message: String
    var processing: Int
    var status: Int
    var success: Bool
    var total: Int
}

struct Data: Codable {
    var id: Int
    var name: String
    var shared: Bool
    var created: String
    var lastModified: String
    var shopper: Shopper?
    var products: [Product]?
    var clasz: String
    var statistics: DataStatistics
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shared
        case created
        case lastModified
        case shopper
        case products
        case clasz = "class"
        case statistics
    }
    
}

struct Shopper: Codable {
    var id: Int
    var nickname: String
}

struct Product: Codable {
    var id: Int
    var name: String
    var ean: Int
    var imageUrl: String
    var stores: [Store]?
    var isbn10: String
    var isbn13: String
    var authors: [String]
    var edition: String
    var numPages: Int
    var rating: Rating
}

struct DataStatistics: Codable {
    var viewed: Int
    var followed: Int
}

struct Store: Codable {
    var id: Int
    var name: String
    var phone: String
    var owner: Owner
    var imageUrl: String
    var inStock: Int
    var price: Double?
    var currency: String
    var location: Location
    var capabilities: [String]?
}

struct Rating : Codable{
    var statistics: RatingStatistics
    var user: String?
}

struct Owner: Codable {
    var id: Int
}

struct Location: Codable {
    var id: Int
    var name: String
    var addressCity: String
    var addressCountry: String
    var addressLine1: String
    var addressState: String
    var addressZip: String
    var latitude: Double
    var longitude: Double
    var timeZoneId: String
    var timeZoneRawOffset: Double
}

struct RatingStatistics: Codable {
    var average: Int?
    var count: Int
    var distribution: Distribution?
}

struct Distribution: Codable {
    var five: Int?
    var three: Int?
    
    
    enum CodingKeys:String, CodingKey {
        case five = "5"
        case three = "3"
    }
}
