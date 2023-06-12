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
        guard let filmListRequest = try? FilmRouter.getAllFilmRequest(baseURL: URL(string: "https://swapi.dev/")!) else {
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
