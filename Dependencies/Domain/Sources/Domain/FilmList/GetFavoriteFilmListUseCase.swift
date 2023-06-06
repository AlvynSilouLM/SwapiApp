//
//  GetFavoriteFilmListUseCase.swift
//

import Data

public protocol GetFavoriteFilmListUseCaseProtocol {
    func perform() async throws -> [Film]
}

public final class GetFavoriteFilmListUseCase {
    fileprivate let repository: FilmRepositoryProtocol

    public init(repository: FilmRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetFavoriteFilmListUseCase: GetFavoriteFilmListUseCaseProtocol {
    public func perform() async throws -> [Film] {
        let filmsDTO: [FilmDTO] = try await repository.getAllFavorites()

        return try FilmListAdapter.convert(filmsDTO)
    }
}
