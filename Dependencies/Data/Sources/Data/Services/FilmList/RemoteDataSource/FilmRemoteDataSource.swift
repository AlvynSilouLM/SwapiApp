//
//  FilmRemoteDataSource.swift
//  V1Exercice
//

import Foundation

public protocol FilmRemoteDataSourceProtocol {
    func getAll() async throws -> [FilmDTO]
}

public final class FilmRemoteDataSource {
    private let request: URLRequest
    private let httpClient: HTTPClient
    private let mapper: FilmListAdapter.Convert

    public init(request: URLRequest,
                httpClient: HTTPClient,
                mapper: @escaping FilmListAdapter.Convert) {
        self.request = request
        self.httpClient = httpClient
        self.mapper = mapper
    }
}

// MARK: - GetAll
extension FilmRemoteDataSource: FilmRemoteDataSourceProtocol {
    public func getAll() async throws -> [FilmDTO] {
        let (data, response) = try await httpClient.fetch(from: request)
        return try mapper(data, response)
    }
}
