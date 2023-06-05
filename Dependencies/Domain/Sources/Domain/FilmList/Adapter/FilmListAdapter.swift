//
//  FilmListAdapter.swift
//

import Foundation
import Data

class FilmListAdapter {
    typealias Convert = ([FilmDTO]) throws -> [Film]

    private init() {}

    static func convert(_ films: [FilmDTO]) throws -> [Film]  {
        return films.toModels()
    }
}

private extension Array where Element == FilmDTO {
    func toModels() -> [Film] {
        map { Film(id: $0.episodeId, title: $0.title, description: $0.openingCrawl) }
    }
}
