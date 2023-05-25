//
//  URLSessionHTTPClientTests.swift
//  V1ExerciceTests
//

import XCTest
import V1Exercice

final class URLSessionHTTPClientTests: XCTestCase {
    private typealias URLContent = (data: Data?, response: URLResponse?, error: Error?)

    override func tearDown() {
        super.tearDown()

        URLProtocolStub.removeStub()
    }

    func test_me1() {

    }

    func test_fetchRequest_performsRequestCorrectlyWithURLHTTPMethodAndHeaders() async throws {
        let expectedRequest: URLRequest = try .stub(httpMethod: "GET", headers: ["Content-Type": "application/json", "Accept": "application/json"])
        let sentRequest = try await fetch(request: expectedRequest)

        XCTAssertEqual(sentRequest, expectedRequest)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)

        let sut = URLSessionHTTPClient(session: session)

        return sut
    }
    
    private func fetch(request: URLRequest) async throws -> URLRequest {

        var sentRequest: URLRequest!
        URLProtocolStub.observeRequests { request in
            sentRequest = request
        }

        _ = try await makeSUT().fetch(from: request)

        return sentRequest
    }
    
}
