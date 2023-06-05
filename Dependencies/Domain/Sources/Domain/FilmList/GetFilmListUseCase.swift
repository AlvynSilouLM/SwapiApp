//
//  GetFilmListUseCase.swift
//

import Foundation
import Data

public final class GetFilmListUseCase {

    private let filmRepository: FilmRepositoryProtocol

    public init(filmRepository: FilmRepositoryProtocol) {
        self.filmRepository = filmRepository
    }
}

extension GetFilmListUseCase: GetAllFilmsUseCaseProtocol {
    public func perform() async throws -> [Film] {
        var filmsDTO = try await filmRepository
            .getAll()
        filmsDTO.sort { $1.episodeId > $0.episodeId }
        return try FilmListAdapter.convert(filmsDTO)
    }
}
