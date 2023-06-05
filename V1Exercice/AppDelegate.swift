//
//  AppDelegate.swift
//  V1Exercice
//

import Foundation
import UIKit
import Data
import Domain

class AppDelegate: NSObject, UIApplicationDelegate {
    lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

    lazy var getFilmListUsecase: GetAllFilmsUseCaseProtocol = {
        guard let filmListRequest = try? FilmListEndpoint.get.request(baseURL: URL(string: "https://swapi.dev/")!) else {
            return NullGetFilmListUseCase()
        }

        let remoteFilmDataSource = FilmRemoteDataSource(request: filmListRequest, httpClient: httpClient, mapper: FilmListAdapter.convert(_:from:))
        let filmRepository = FilmRepository(remoteDataSource: remoteFilmDataSource)

        let filmListLoader = GetFilmListUseCase(filmRepository: filmRepository)

        return filmListLoader
    }()
}


private class NullGetFilmListUseCase: GetAllFilmsUseCaseProtocol {
    func perform() async throws -> [Domain.Film] {
        return []
    }
}
