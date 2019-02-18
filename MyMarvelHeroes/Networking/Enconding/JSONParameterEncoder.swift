//
//  JSONParameterEncoder.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 15/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw ParameterEncoderError.encondingFailed
        }
    }
}
