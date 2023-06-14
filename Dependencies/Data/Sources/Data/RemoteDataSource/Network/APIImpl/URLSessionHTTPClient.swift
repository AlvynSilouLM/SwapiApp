//
//  URLSessionHTTPClient.swift
//  V1Exercice
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    public static let shared: HTTPClient = URLSessionHTTPClient()

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func fetch(from request: URLRequest) async throws -> HTTPClient.Result {
        return try await session.data(for: request)
    }
}
