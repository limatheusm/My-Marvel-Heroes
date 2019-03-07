//
//  MarvelAPIConstants.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

// MARK: - Marvel API Constants

extension MarvelAPI {
    struct Constants {
        
        // MARK: - URL constants
        
        static let APIScheme = "https"
        static let APIHost = "gateway.marvel.com"
        static let APIPath = "/v1/public"
        static let BaseURLProduction = "\(APIScheme)://\(APIHost)\(APIPath)"
        static let BaseURLQA = ""
        static let BaseURLStaging = ""
        static let ThumbnailStandardSize = "standard_fantastic"
        static let ThumbnailPortraitSiza = "portrait_uncanny"
        static let ImageNotAvailable = "image_not_available"
        static let InfiniteScrollLimiar = 5
        static let DateFormat = "yyyy-MM-dd'T'HH:mm:ss-SSSS"
        
        // MARK: - Request constants
        
        static let PublicKey = "27c054e3386f256fb2682371249678f9"
        static let PrivateKey = "d659c30e5f62c04b35006f6837719d9b84694571"
        
        // MARK: - Paths Methods
        
        struct PathsMethods {
            static let Characters = "/characters"
            static let HeroArtifacts = "/characters/{id}/{type}"
        }
        
        // MARK: - Parameters Keys
        
        struct ParametersKeys {
            static let Ts = "ts"
            static let APIKey = "apikey"
            static let hash = "hash"
            static let NameStartsWith = "nameStartsWith"
            static let Offset = "offset"
            static let Limit = "limit"
        }
        
        // MARK: - Parameters Values
        
        struct ParametersValues {
            static let APIKey = PublicKey
            static let Limit = 20
        }
        
        // MARK: - Response Values
        
        struct ResponseValues {
            static let OKStatus = "Ok"
        }
    }
}
