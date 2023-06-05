//
//  FilmListEndpoint.swift
//  V1Exercice
//
//  Created by Alvyn S on 26/05/2023.
//

import Foundation

public enum FilmListEndpoint {
    private struct CannotCreateURLRequest: Error {}

    case get

    public func request(baseURL: URL) throws -> URLRequest {
        switch self {
        case .get:
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/api/films"

            guard let url = components.url else {
                throw CannotCreateURLRequest()
            }

            return URLRequest(url: url)
        }
    }
}
