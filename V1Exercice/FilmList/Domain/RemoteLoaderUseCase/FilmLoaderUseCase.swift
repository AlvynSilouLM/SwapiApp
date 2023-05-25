//
//  FilmLoaderUseCase.swift
//  V1Exercice
//

import Foundation

public final class FilmLoaderUseCase {
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

// MARK: - Load
extension FilmLoaderUseCase: FilmLoader {
    public func load() async throws -> [Film] {
        let (data, response) = try await httpClient.fetch(from: request)
        return try mapper(data, response)
    }
}
