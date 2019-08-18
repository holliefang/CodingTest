//
//  Token.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/18.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import Foundation

class Token {
    private init() {
    }
    static let shared = Token()
    var token = ""
}
