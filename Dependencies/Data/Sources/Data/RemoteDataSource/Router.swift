//
//  File.swift
//  
//
//  Created by Alvyn S on 13/06/2023.
//

import Foundation

public final class Router {
    private struct CannotCreateURLRequest: Error {}

    private let baseURL: URL?

    public init(baseURL: URL?) {
        self.baseURL = baseURL
    }

    public func request(httpMethod: HTTPMethod, path: String) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = baseURL?.scheme
        components.host = baseURL?.host
        components.path = (baseURL?.path ?? "") + path

        guard let url = components.url else {
            throw CannotCreateURLRequest()
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        return request
    }
}

