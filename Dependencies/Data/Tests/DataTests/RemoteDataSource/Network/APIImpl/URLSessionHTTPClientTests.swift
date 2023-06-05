//
//  URLSessionHTTPClientTests.swift
//  V1ExerciceTests
//

import XCTest
import Data

final class URLSessionHTTPClientTests: XCTestCase {
    private typealias URLContent = (data: Data?, response: URLResponse?, error: Error?)

    override func tearDown() {
        super.tearDown()

        URLProtocolStub.removeStub()
    }

    func test_fetchRequest_performsRequestCorrectlyWithURLHTTPMethodAndHeaders() async throws {
        let expectedRequest: URLRequest = try .stub(httpMethod: "GET", headers: ["Content-Type": "application/json", "Accept": "application/json"])
        let sentRequest = try await fetch(request: expectedRequest)

        XCTAssertEqual(sentRequest, expectedRequest)
    }

    func test_fetchRequest_performsRequestCorrectlyWithBodyParameters() async throws {
        let bodyString = "{\"id\": 4}"
        let expectedData = Data.stub(with: bodyString)
        let expectedRequest = try URLRequest.stub(httpMethod: "POST", data: expectedData)

        let sentRequest = try await fetch(request: expectedRequest)

        expect(request: sentRequest, hasBody: bodyString)
    }

    func test_fetchRequest_failsOnRequestError() async throws {
        let requestError = NSError(domain: "any error", code: 1)

        let receivedError = try await resultErrorFor((data: nil, response: nil, error: requestError)) as? NSError

        XCTAssertEqual(receivedError?.domain, requestError.domain)
        XCTAssertEqual(receivedError?.code, requestError.code)
    }

    func test_fetchRequest_succeedsOnHTTPURLResponseWithData() async throws {
        let data = Data.stub()
        let response = try HTTPURLResponse.stub(statusCode: 204)

        let receivedValues = await resultValuesFor((data: data, response: response, error: nil))

        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual((receivedValues?.response as? HTTPURLResponse)?.statusCode, response.statusCode)
    }

    // MARK: - Helpers

    private func makeSUT() -> HTTPClient {
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

    private func resultErrorFor(_ urlContent: URLContent? = nil, file: StaticString = #file, line: UInt = #line) async throws -> Error? {
        do {
            let result = try await resultFor(urlContent)
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        } catch {
            return error
        }
    }

    private func resultValuesFor(_ urlContent: URLContent? = nil, file: StaticString = #file, line: UInt = #line) async -> (data: Data, response: URLResponse)? {
        do {
            let values = try await resultFor(urlContent)
            return values
        } catch {
            XCTFail("Expected success, got \(error) instead", file: file, line: line)
            return nil
        }
    }

    private func resultFor(_ urlContent: URLContent? = nil) async throws -> HTTPClient.Result {
        urlContent.map { URLProtocolStub.stub(data: $0, response: $1, error: $2) }
        let sut = makeSUT()

        return try await sut.fetch(from: try URLRequest.stub())
    }

    private func expect(request: URLRequest, hasBody body: String?, file: StaticString = #filePath, line: UInt = #line) {
        let dataSent = request.httpBody ?? request.httpBodyStream?.readfully()

        guard let body = body
        else {
            XCTAssertNil(dataSent, "Expect request.httpBody to be nil but got \(String(describing: dataSent))", file: file, line: line)
            return
        }

        if let dataSent = dataSent {
            XCTAssertEqual(String(data: dataSent, encoding: .utf8), body, file: file, line: line)
        } else {
            XCTFail("Expect request.httpBody to be \(body) but got \(String(describing: dataSent))", file: file, line: line)
        }
    }
    
}

private extension InputStream {
    func readfully() -> Data {
        var result = Data()
        var buffer = [UInt8](repeating: 0, count: 4096)

        open()

        var amount = 0
        repeat {
            amount = read(&buffer, maxLength: buffer.count)
            if amount > 0 {
                result.append(buffer, count: amount)
            }
        } while amount > 0

        close()

        return result
    }
}
