//
//  MarvelAPIManager.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is otdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case poorNetworkConnection = "Please check your network connection"
    case okStatusNotFound = "Marvel API returned an error"
    case imageNotAvailable = "Image is not available"
}

enum Result<T> {
    case success(T)
    case failure(String)
}

final class MarvelAPIManager {
    
    // MARK: - Singleton
    static let sharedInstance = MarvelAPIManager()
    private init () { }
    
    static let environment: NetworkEnviroment = .production
    static let credentials = ""
    private let router = Router<MarvelAPI>()
    
    // MARK: - Convenience Methods
    
    func getHeroes(nameStartsWith: String? = nil, page: Int = 0, completion: @escaping (_ result: Result<HeroDataContainer>) -> Void) {
        let offset = page * MarvelAPI.Constants.ParametersValues.Limit
        
        router.request(.getCharacters(nameStartsWith, offset)) { (data, response, error) in
            let networkResponseResult = self.handleNetworkResponse(response, error)
            
            switch networkResponseResult {
            case .success:
                guard let responseData = data else {
                    completion(.failure(NetworkResponse.noData.rawValue))
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(HeroDataWrapper.self, from: responseData)
                    
                    guard apiResponse.status == MarvelAPI.Constants.ResponseValues.OKStatus else {
                        completion(.failure(NetworkResponse.okStatusNotFound.rawValue))
                        return
                    }
                    
                    guard let heroesData = apiResponse.data else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    
                    completion(.success(heroesData))
                    
                } catch {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }
            case .failure(let networkFailureError):
                completion(.failure(networkFailureError))
            }
        }
    }
    
    func downloadThumbnail(from url: String?, completion: @escaping (_ result: Result<UIImage?>) -> Void) {
        /* Check if contain available url and image from api */
        guard let url = url, !url.contains(MarvelAPI.Constants.ImageNotAvailable) else {
            completion(.failure(NetworkResponse.imageNotAvailable.rawValue))
            return
        }
        
        /* Check if image is already in the cache */
        if let imageCache = MarvelDataSource.sharedInstance.cacheImages.object(forKey: url as NSString) {
            completion(.success(imageCache.image))
            return
        }
        
        self.router.request(.downloadThumb(url), completion: { (data, response, error) in
            switch self.handleNetworkResponse(response, error) {
            case .success:
                guard let imageData = data else {
                    completion(.failure(NetworkResponse.noData.rawValue))
                    return
                }
                
                guard let uiImage = UIImage(data: imageData) else {
                    completion(.failure(NetworkResponse.failed.rawValue))
                    return
                }
                
                /* Cache the image */
                MarvelDataSource.sharedInstance.cacheImages.setObject(ImageCache(uiImage), forKey: url as NSString)
                completion(.success(uiImage))
                
            case .failure(let networkFailureError):
                completion(.failure(networkFailureError))
            }
        })
    }
}

// MARK: - Helpers

extension MarvelAPIManager {
    fileprivate func handleNetworkResponse(_ response: URLResponse?, _ error: Error?) -> Result<Bool> {
        guard error == nil else {
            return .failure(NetworkResponse.poorNetworkConnection.rawValue)
        }
        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkResponse.failed.rawValue)
        }
        
        switch response.statusCode {
        case 200...299: return .success(true)
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

}
