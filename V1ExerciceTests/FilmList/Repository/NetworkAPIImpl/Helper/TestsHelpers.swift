//
//  TestsHelpers.swift
//  V1ExerciceTests
//

import Foundation

extension URL {
    static func stub(with urlString: String = "https://any-url.com") throws -> URL {
        guard let url = URL(string: urlString) else {
            throw "Invalid error"
        }
        return url
    }
}

extension URLRequest {
    static func stub(url:  () throws -> URL = { try URL.stub() },
                     httpMethod: String = "GET",
                     data: Data? = nil,
                     headers: [String: String] = [:]) throws -> URLRequest {
        var request = URLRequest(url: try url())
        request.httpMethod = httpMethod
        request.httpBody = data

        return request.append(headers: headers)
    }
}


extension HTTPURLResponse {
    static func stub(url:  () throws -> URL = { try URL.stub() },
                     statusCode: Int = 200) throws -> HTTPURLResponse? {

        HTTPURLResponse(url: try url(), statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}

private extension URLRequest {
    func append(headers: [String: String]) -> URLRequest {
        var request = self
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}

extension String: Error { }

