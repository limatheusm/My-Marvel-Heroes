//
//  Hero.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct HeroDataWrapper: Codable {
    let code: Int?
    let status: String?
    let etag: String?
    let data: HeroDataContainer?
}

struct HeroDataContainer: Codable {
    let offset, limit, total, count: Int?
    let results: [Hero]?
}

struct Hero: Codable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: Comics?
    let series: Series?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?
}

struct URLElement: Codable {
    let type: String?
    let url: String?
}
