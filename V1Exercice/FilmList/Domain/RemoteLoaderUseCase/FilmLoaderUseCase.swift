//
//  FilmLoaderUseCase.swift
//  V1Exercice
//

import Foundation

public final class FilmLoaderUseCase {
    private let request: URLRequest
    private let httpClient: HTTPClient

    public init(request: URLRequest,
                httpClient: HTTPClient) {
        self.request = request
        self.httpClient = httpClient
    }
}

// MARK: - Load
extension FilmLoaderUseCase: FilmLoader {
    public func load() async throws -> [Film] {
        try await httpClient.fetch(from: request)
        return []
    }
}
