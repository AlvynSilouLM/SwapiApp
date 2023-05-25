//
//  FilmLoaderUseCaseTests.swift
//  V1ExerciceTests
//

import XCTest
import V1Exercice

final class FilmLoaderUseCaseTests: XCTestCase {

    func test_init_shouldNotMessageHTTPClient() throws {
        let (_, httpClientSpy) = try makeSUT()

        XCTAssertEqual(httpClientSpy.callCount, 0)
    }

    func test_load_shouldLoadFilmsFromHTTPClient() async throws {
        let request = try URLRequest.stub()
        let (sut, httpClient) = try makeSUT(request: request)
        httpClient.stub()

        let result = try await sut.load()

        XCTAssertEqual(httpClient.callCount, 1)
        XCTAssertEqual(httpClient.request(), request)
    }

    // MARK: - Helpers
    private func makeSUT(request: @autoclosure () throws -> URLRequest = try URLRequest.stub()) throws -> (FilmLoaderUseCase, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let loadFilmUsecase = FilmLoaderUseCase(request: try URLRequest.stub(), httpClient: httpClient)

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

