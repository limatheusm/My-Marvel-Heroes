//
//  MarvelDataSource.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 23/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

final class MarvelDataSource {
    let cacheImages = NSCache<NSString, ImageCache>()
    
    /* Singleton */
    static let sharedInstance = MarvelDataSource()
    private init () { }
}
