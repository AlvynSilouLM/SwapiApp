//
//  FilmListEndpointTests.swift
//  V1ExerciceTests
//

import XCTest
import V1Exercice

final class FilmListEndpointTests: XCTestCase {
    func test_filmList_endpointURL() throws {
        let baseURL = URL(string: "http://base-url.com")!

        let received = try XCTUnwrap(try FilmListEndpoint.get.request(baseURL: baseURL).url)

        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/api/films", "path")
    }
}
