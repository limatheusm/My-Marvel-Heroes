//
//  String+Hash.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    var MD5: String? {
        guard let messageData = self.data(using:.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
