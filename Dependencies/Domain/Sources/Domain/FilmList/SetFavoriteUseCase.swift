//
//  SetFavoriteUseCase.swift
//  
//

import Data

public final class SetFavoriteUseCase {
    let repository: FilmRepositoryProtocol

    public init(repository: FilmRepositoryProtocol = FilmRepository()) {
        self.repository = repository
    }
}

extension SetFavoriteUseCase: SetFavoriteUseCaseProtocol {
    public func perform(_ film: Film) async throws -> Bool {
        try await repository.setFavorite(FilmListAdapter.convert(film))
    }
}
