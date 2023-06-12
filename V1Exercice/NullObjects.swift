//
//  NullObjects.swift
//  V1Exercice
//

import Foundation
import Data
import Domain

internal class NullGetFilmListUseCase: GetAllFilmsUseCaseProtocol {
    func perform() async throws -> [Domain.Film] {
        return []
    }
}

internal class NullSetFavoriteFilmUseCase: SetFavoriteUseCaseProtocol {
    func perform(_ film: Film) async throws -> Bool {
        return false
    }
}

internal class NullFilmLocalDataSource: FilmLocalDataSourceProtocol {
    func getAll() async throws -> [FilmDTO] {
        return []
    }

    func setFavorite(_ film: FilmDTO) async throws -> Bool {
        return false
    }
}


internal class NullFilmRemoteDataSource: FilmRemoteDataSourceProtocol {
    func getAll() async throws -> [FilmDTO] {
        []
    }
}

internal class NullGetFavoriteFilmListUseCase: GetFavoriteFilmListUseCaseProtocol {
    func perform() async throws -> [Film] {
        []
    }
}
