//
//  HTTPClient.swift
//  V1Exercice
//
//

import Foundation

public protocol HTTPClient {
    typealias Result = (Data, URLResponse)

    @discardableResult
    func fetch(from request: URLRequest) async throws -> Result
}
