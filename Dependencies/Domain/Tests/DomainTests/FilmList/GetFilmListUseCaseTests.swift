//
//  GetFilmListUseCaseTests.swift
//

import XCTest
import Data
import Domain

final class GetFilmListUseCaseTests: XCTestCase {
    func test_init_doesNotMessageRepository() {
        let (_, repository) = makeSUT()

        XCTAssertEqual(repository.getAllCallCount, 0)
    }

    func test_perform_requestFilmFromRepository() async throws {
        let (sut, repository) = makeSUT()

        let _ = try await sut.perform()

        XCTAssertEqual(repository.getAllCallCount, 1)
    }

    func test_perform_failsOnGetAllFailure() async {
        let (sut, repository) = makeSUT()
        repository.stubGetAll(with: NSError(domain: "testError", code: 1090))

        var receivedError: Error?
        do {
            let _ = try await sut.perform()
        } catch {
            receivedError = error
        }

        XCTAssertNotNil(receivedError, "No error thrown")
    }

    func test_perform_succeedOnSuccessfulyGetAll() async throws {
        let (sut, repository) = makeSUT()
        let film1 = Film.stub(id: 10)
        let film2 = Film.stub(id: 6)

        let filmsDTO =  [film1.dto, film2.dto]
        repository.stubGetAll(with: filmsDTO)

        let result = try await sut.perform()

        XCTAssertEqual(result, [film2.model, film1.model], "Films not equal and sorted")
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: GetFilmListUseCase, repository: FilmRepositorySpy) {
        let repository = FilmRepositorySpy()
        let sut = GetFilmListUseCase(filmRepository: repository)

        return (sut, repository)
    }

}

private class FilmRepositorySpy: FilmRepositoryProtocol {

    var getAllCallCount: Int = 0

    private var getAllResult: Swift.Result<[FilmDTO], Error> = .success([])

    func getAll() async throws -> [FilmDTO] {
        getAllCallCount += 1
        return try getAllResult.get()
    }

    func setFavorite(_ film: FilmDTO) async throws -> Bool {
        false
    }

    func getAllFavorites() async throws -> [FilmDTO] {
        []
    }

    // MARK: - Helpers
    func stubGetAll(with dto: [FilmDTO]) {
        getAllResult = .success(dto)
    }

    func stubGetAll(with error: Error) {
        getAllResult = .failure(error)
    }
}
