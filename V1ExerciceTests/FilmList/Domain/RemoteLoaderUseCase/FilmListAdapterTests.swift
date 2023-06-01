//
//  FilmListAdapterTests.swift
//  V1ExerciceTests
//

import XCTest
import V1Exercice

final class FilmListAdapterTests: XCTestCase {
    func test_adapt_throwsErrorOnNon200HTTPResponse() throws {
        let jsonData = try Data.makeJSON(from: [:])
        let samples = [199, 201, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try FilmListAdapter.convert(jsonData, from: HTTPURLResponse.stub(statusCode: code))
            )
        }
    }

    func test_adapt_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSONData = Data("invalid json".utf8)

        XCTAssertThrowsError(
            try FilmListAdapter.convert(invalidJSONData, from: HTTPURLResponse.stub(statusCode: 200))
        )
    }

    func test_adapt_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = try Data.makeJSON(from: ["results": []])

        let result = try FilmListAdapter.convert(emptyListJSON, from: HTTPURLResponse.stub(statusCode: 200))

        XCTAssertEqual(result, [])
    }

    func test_adapt_deliversResultsOn200HTTPResponseWithJSONFilms() throws {
        let film1 = Film.stub()

        let film2 = Film.stub(title: "Film Title 2")

        let json = try Data.makeJSON(from: ["results": [film1.json, film2.json]])

        let result = try FilmListAdapter.convert(json, from: HTTPURLResponse.stub(statusCode: 200))

        XCTAssertEqual(result, [film1.model, film2.model])
    }
}
