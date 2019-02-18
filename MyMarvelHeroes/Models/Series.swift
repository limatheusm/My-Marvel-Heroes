//
//  Series.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct Series: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesItem]?
    let returned: Int?
}

struct SeriesItem: Codable {
    let resourceURI: String?
    let name: String?
}
