//
//  DataTestsHelper.swift
//  DataTests
//

import Foundation

#if DEBUG
public extension FilmDTO {
    static func stub(id: Int = Int.random(in: 1...1000000),
                     title: String = "Film title",
                     description: String = "Film Description") -> (dto: FilmDTO, json: [String: Any]) {
        let dto = FilmDTO(title: title, episodeId: id, openingCrawl: description)
        let json: [String: Any] = [
            "episode_id": id,
            "opening_crawl": description,
            "title": title,
        ]

        return (dto, json)
    }
}
#endif
