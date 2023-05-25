//
//  DomainTestsHelper.swift
//  V1ExerciceTests
//

import Foundation
import V1Exercice

extension Film {
    static func stub(id: Int = Int.random(in: 1...1000000),
                     title: String = "Film title",
                     description: String = "Film Description") -> (model: Film, json: [String: Any]) {

        let film = Film(id: id, title: title, description: description)
        let json: [String: Any] = [
            "episode_id": id,
            "opening_crawl": description,
            "title": title,
        ]

        return (film, json)
    }
}
