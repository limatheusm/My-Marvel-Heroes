//
//  ParameterEnconding.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 15/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoderError: String, Error {
    case parametersNil = "Parameters were nil"
    case encondingFailed = "Parameters enconding failed"
    case missingURL = "URL is nil"
}
