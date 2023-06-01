//
//  FilmListAdapter.swift
//  V1Exercice
//
//

import Foundation

public class FilmListAdapter {
    public typealias Convert = (_ data: Data, _ response: URLResponse) throws -> [Film]

    private init() {}

    enum Error: Swift.Error {
        case invalidData
    }

    public static func convert(_ data: Data, from response: URLResponse) throws -> [Film]  {
        guard let response = response as? HTTPURLResponse, response.isOK200 else {
            throw Error.invalidData
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let filmListResult = try jsonDecoder.decode(FilmListRoot.self, from: data)

        return filmListResult.results.toModels()
    }
}

extension Array where Element == FilmListAdapter.FilmDTO {
    func toModels() -> [Film] {
        map { Film(id: $0.episodeId, title: $0.title, description: $0.openingCrawl) }
    }
}

fileprivate extension FilmListAdapter {
    struct FilmListRoot: Decodable {
        let results: [FilmDTO]
    }

    struct FilmDTO: Decodable {
        let title: String
        let episodeId: Int
        let openingCrawl: String
    }
}

private extension HTTPURLResponse {
    var isOK200: Bool {
        statusCode == 200
    }
}
