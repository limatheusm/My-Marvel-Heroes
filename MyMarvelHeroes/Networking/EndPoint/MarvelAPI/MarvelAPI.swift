//
//  MarvelAPI.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation


public enum MarvelAPI {
    case getCharacters(_ nameStartsWith: String?, _ offset: Int)
    case downloadThumb(_ fromUrl: String)
    case getHeroArtifacts(_ type: ArtifactType, _ heroID: Int, _ offset: Int)
}

// MARK: - EndPointType Protocol

extension MarvelAPI: EndPointType {
    var environmentBaseURL: String {
        switch MarvelAPIManager.environment {
        case .production:
            return Constants.BaseURLProduction
        case .qa:
            return Constants.BaseURLQA
        case .staging:
            return Constants.BaseURLStaging
        }
    }
    
    public var baseURL: URL {
        var baseURL = ""
        switch self {
        case .downloadThumb(let url):
            baseURL = url
        default:
            baseURL = environmentBaseURL
        }
        
        guard let url = URL(string: baseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    public var path: String {
        switch self {
        case .getCharacters:
            return Constants.PathsMethods.Characters
        case .getHeroArtifacts(let type, let heroID, _):
            return Constants.PathsMethods.HeroArtifacts.replacingOccurrences(of: "{id}", with: "\(heroID)").replacingOccurrences(of: "{type}", with: "\(type.path)")
        default:
            return ""
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: HTTPTask {
        let ts = String(Date().timeIntervalSince1970)
        let commonUrlParameters: Parameters = [
            Constants.ParametersKeys.Ts: ts,
            Constants.ParametersKeys.APIKey: Constants.ParametersValues.APIKey,
            Constants.ParametersKeys.hash: "\(ts)\(MarvelAPI.Constants.PrivateKey)\(MarvelAPI.Constants.PublicKey)".MD5 ?? "",
            Constants.ParametersKeys.Limit: Constants.ParametersValues.Limit
        ]
        
        switch self {
        case .getCharacters(let nameStartsWith, let offset):
            var urlParameters = commonUrlParameters
            urlParameters[Constants.ParametersKeys.Offset] = offset
            if let nameStartsWith = nameStartsWith {
                urlParameters[Constants.ParametersKeys.NameStartsWith] = nameStartsWith
            }
            
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        case .getHeroArtifacts:
            return .requestParameters(bodyParameters: nil, urlParameters: commonUrlParameters)
        case .downloadThumb(let url):
            return .download(url)
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
