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

    static func convert(_ film: Film) -> FilmDTO {
        FilmDTO(title: film.title, episodeId: film.id, openingCrawl: film.description)
    }
}

private extension Array where Element == FilmDTO {
    func toModels() -> [Film] {
        map { Film(id: $0.episodeId, title: $0.title, description: $0.openingCrawl) }
    }
}
