//
//  FilmRemoteDataSourceTests.swift
//  V1ExerciceTests
//

import XCTest
import Data

final class FilmRemoteDataSourceTests: XCTestCase {

    func test_init_shouldNotMessageHTTPClient() throws {
        let (_, httpClientSpy) = try makeSUT()

        XCTAssertEqual(httpClientSpy.callCount, 0)
    }

    func test_load_shouldLoadFilmsFromHTTPClient() async throws {
        let film1 = FilmDTO.stub()
        let dataJson = try Data.makeJSON(from: ["results": [film1.json]])
        let response = try HTTPURLResponse.stub(statusCode: 200)

        let request = try URLRequest.stub()
        var receivedResponse: URLResponse?
        var receivedData: Data?
        let mapper: (Data, URLResponse) throws -> [FilmDTO] = {
            receivedData = $0
            receivedResponse = $1
            return [film1.dto]
        }
        let (sut, httpClient) = try makeSUT(request: request, mapper: mapper)
        httpClient.stub(data: dataJson, response: response )

        let filmlist = try await sut.getAll()

        XCTAssertEqual(httpClient.callCount, 1)
        XCTAssertEqual(httpClient.request(), request)
        XCTAssertEqual(filmlist, [film1.dto])
        XCTAssertEqual(receivedData, dataJson)
        XCTAssertEqual(receivedResponse, response)
    }

    // MARK: - Helpers
    private func makeSUT(request: @autoclosure () throws -> URLRequest = try URLRequest.stub(),
                         mapper: @escaping (Data, URLResponse) throws -> [FilmDTO] = { _, _ in [] }) throws -> (FilmRemoteDataSource, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let loadFilmUsecase = FilmRemoteDataSource(request: try URLRequest.stub(),
                                                httpClient: httpClient,
                                                mapper: mapper)

        return (loadFilmUsecase, httpClient)
    }
}

private final class HTTPClientSpy: HTTPClient {
    typealias URLContent = (data: Data?, response: URLResponse?, error: Error?)

    var stub: URLContent?

    var callCount: Int {
        fetchArgs.count
    }

    private var fetchArgs: [URLRequest] = []

    func fetch(from request: URLRequest) async throws -> HTTPClient.Result {
        fetchArgs.append(request)
        if let error = stub?.error {
            throw error
        }

        if let data = stub?.data,
           let response = stub?.response {
            return (data, response)
        }

        throw NSError()
    }

    // MARK: - Helpers
    func request(at index: Int = 0) -> URLRequest {
        fetchArgs[index]
    }

    func stub(data: Data? = Data.stub(),
              response: URLResponse? = HTTPURLResponse(),
              error: Error? = nil) {
        stub = (data, response, error)
    }
}

