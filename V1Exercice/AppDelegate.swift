//
//  AppDelegate.swift
//  V1Exercice
//

import Foundation
import UIKit
import Data
import Domain

class AppDelegate: NSObject, UIApplicationDelegate {

    lazy var getFilmListUsecase: GetAllFilmsUseCaseProtocol = {
        return GetFilmListUseCase(filmRepository: filmRepository)
    }()

    lazy var setFilmFavorite: SetFavoriteUseCaseProtocol = {
        return SetFavoriteUseCase(repository: filmRepository)
    }()

    lazy var getFavoritesFilmsUseCase: GetFavoriteFilmListUseCaseProtocol = {
        return GetFavoriteFilmListUseCase(repository: filmRepository)
    }()

    private lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

    private lazy var filmRepository: FilmRepositoryProtocol = {
        return FilmRepository(remoteDataSource: filmRemoteDataSource,
                              localDataSource: filmLocalDataSource)

    }()

    private lazy var filmRemoteDataSource: FilmRemoteDataSourceProtocol = {
        guard let filmListRequest = try? FilmListEndpoint.get.request(baseURL: URL(string: "https://swapi.dev/")!) else {
            return NullFilmRemoteDataSource()
        }

        return FilmRemoteDataSource(request: filmListRequest,
                                    httpClient: httpClient,
                                    mapper: FilmListAdapter.convert(_:from:))
    }()

    private lazy var filmLocalDataSource: FilmLocalDataSourceProtocol = {
        guard let storeURL = try? FileManager.default.url(for: .documentDirectory,
                                                          in: .userDomainMask,
                                                          appropriateFor: nil,
                                                          create: false)
            .appendingPathComponent("favorites.data") else {
            return NullFilmLocalDataSource()
        }

        let database = FilmDatabase(databaseURL: storeURL)

       return FilmLocalDataSource(database: database)
    }()
}


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
