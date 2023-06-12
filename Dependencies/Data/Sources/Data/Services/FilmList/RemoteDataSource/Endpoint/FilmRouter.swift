//
//  FilmRouter.swift
//  V1Exercice
//
//  Created by Alvyn S on 26/05/2023.
//

import Foundation

public struct FilmRouter {
    var baseURL: URL

    private struct CannotCreateURLRequest: Error {}

    public func request(httpMethod: HTTPMethod, path: String) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + path

        guard let url = components.url else {
            throw CannotCreateURLRequest()
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return URLRequest(url: url)

    }

    public static func getAllFilmRequest(baseURL: URL) throws -> URLRequest {
        try FilmRouter(baseURL: baseURL).request(httpMethod: .get, path: "/api/films")
    }
}
