//
//  TestsHelpers.swift
//  V1ExerciceTests
//

import Foundation

extension Data {
    static func makeJSON(from jsonDict: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: jsonDict)
    }
}

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
                     statusCode: Int = 200) throws -> HTTPURLResponse {
        guard let response = HTTPURLResponse(url: try url(), statusCode: statusCode, httpVersion: nil, headerFields: nil) else {
            throw "Cannot create response"
        }

        return response
    }
}

extension Data {
    static func stub(with content: String = "{\"id\": 4}") -> Data {
        Data(content.utf8)
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

