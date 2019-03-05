//
//  Thumbnail.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let ext: String?
    
    var url: String? {
        guard path != nil, ext != nil else { return nil }
        return path! + "/\(MarvelAPI.Constants.ThumbnailStandardSize)." + ext!
    }
    
    var portraitUrl: String? {
        guard path != nil, ext != nil else { return nil }
        return path! + "/\(MarvelAPI.Constants.ThumbnailPortraitSiza)." + ext!
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
