//
//  FilmListAdapter.swift
//  V1Exercice
//
//

import Foundation

public class FilmListAdapter {
    public typealias Convert = (_ data: Data, _ response: URLResponse) throws -> [FilmDTO]

    private init() {}

    enum Error: Swift.Error {
        case invalidData
    }

    public static func convert(_ data: Data, from response: URLResponse) throws -> [FilmDTO]  {
        guard let response = response as? HTTPURLResponse, response.isOK200 else {
            throw Error.invalidData
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let filmListResult = try jsonDecoder.decode(FilmListRoot.self, from: data)

        return filmListResult.results
    }
}

fileprivate extension FilmListAdapter {
    struct FilmListRoot: Decodable {
        let results: [FilmDTO]
    }
}

private extension HTTPURLResponse {
    var isOK200: Bool {
        statusCode == 200
    }
}
