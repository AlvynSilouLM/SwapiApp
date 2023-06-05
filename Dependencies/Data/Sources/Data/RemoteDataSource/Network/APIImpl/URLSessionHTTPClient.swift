//
//  URLSessionHTTPClient.swift
//  V1Exercice
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func fetch(from request: URLRequest) async throws -> HTTPClient.Result {
        return try await session.data(for: request)
    }
}
