//
//  extensions.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/18.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit

extension String {
    func getImage() -> UIImage? {
        let url = URL(string: self)
        if let data = try? Foundation.Data(contentsOf: url!) {
            let image = UIImage (data: data)
            return image
            }
        return nil
    }
}

extension Array {
    func allString() -> String? {
        var result = ""
        var count = 0
        for element in self {
            if let text = element as? String {
                count += 1
                if count == self.count {
                    result += text
                } else {
                    result += text + ", "
                }
            } else {
                return nil
            }
        }
        return result
    }
}
