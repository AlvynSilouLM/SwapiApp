//
//  FilmListEndpointTests.swift
//  V1ExerciceTests
//

import XCTest
import Data

final class FilmListEndpointTests: XCTestCase {
    func test_filmList_endpointURL() throws {
        let baseURL = URL(string: "http://base-url.com")!

        let received = try XCTUnwrap(try FilmRouter.getAllFilmRequest(baseURL: baseURL).url)

        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path, "/api/films", "path")
    }
}
