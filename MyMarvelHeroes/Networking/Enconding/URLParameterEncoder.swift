//
//  URLParameterEncoder.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 15/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

/// Takes parameters and makes then safe to be passed as URL Parameters
public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw ParameterEncoderError.missingURL }
        guard !parameters.isEmpty else { throw ParameterEncoderError.parametersNil }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
