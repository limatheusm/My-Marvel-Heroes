//
//  Artifact.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 01/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

public enum ArtifactType {
    case comic
    case serie
    case storie
}

extension ArtifactType {
    var path: String {
        switch self {
        case .comic:
            return "comics"
        case .serie:
            return "series"
        case .storie:
            return "stories"
        }
    }
}

struct ArtifactDataWrapper: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ArtifactContainer?
}

struct ArtifactContainer: Codable {
    let offset, limit, total, count: Int?
    let results: [Artifact]?
}

struct Artifact: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let isbn: String?
    let pageCount: Int?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
}
