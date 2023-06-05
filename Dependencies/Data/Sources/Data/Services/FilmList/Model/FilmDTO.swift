//
//  FilmDTO.swift
//

import Foundation

public struct FilmDTO: Decodable, Equatable {
    public let title: String
    public let episodeId: Int
    public let openingCrawl: String

    public init(title: String, episodeId: Int, openingCrawl: String) {
        self.title = title
        self.episodeId = episodeId
        self.openingCrawl = openingCrawl
    }
}
