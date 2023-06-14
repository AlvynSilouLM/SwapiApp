//
//  FilmRemoteDataSource.swift
//  V1Exercice
//

import Foundation

public protocol FilmRemoteDataSourceProtocol {
    func getAll() async throws -> [FilmDTO]
}

public final class FilmRemoteDataSource {
    private let router: Router
    private let httpClient: HTTPClient

    private struct Constants {
        private init() {}
        static var baseURL = "https://swapi.dev"
    }

    public init(httpClient: HTTPClient = URLSessionHTTPClient.shared) {
        self.router = Router(baseURL: URL(string: Constants.baseURL))
        self.httpClient = httpClient
    }
}

// MARK: - GetAll
extension FilmRemoteDataSource: FilmRemoteDataSourceProtocol {
    public func getAll() async throws -> [FilmDTO] {
        let getAllFilmRequest = try router.getAllFilmRequest()
        let (data, response) = try await httpClient.fetch(from: getAllFilmRequest)
        return try FilmListAdapter.convert(data, from: response)
    }
}
