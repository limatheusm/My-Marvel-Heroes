//
//  Events.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 17/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

struct Events: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [EventsItem]?
    let returned: Int?
}

struct EventsItem: Codable {
    let resourceURI: String?
    let name: String?
}
