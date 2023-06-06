//
//  FilmListRepository.swift
//  
//

import Foundation

public protocol FilmRepositoryProtocol {
    func getAll() async throws -> [FilmDTO]
    func setFavorite(_ film: FilmDTO) async throws -> Bool
    func getAllFavorites() async throws -> [FilmDTO]
}

public final class FilmRepository {

    var remoteDataSource: FilmRemoteDataSourceProtocol
    var localDataSource: FilmLocalDataSourceProtocol

    public init(remoteDataSource: FilmRemoteDataSourceProtocol, localDataSource: FilmLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

extension FilmRepository: FilmRepositoryProtocol  {

    public func getAll() async throws -> [FilmDTO] {
        try await remoteDataSource.getAll()
    }

    public func setFavorite(_ film: FilmDTO) async throws -> Bool {
        try await localDataSource.setFavorite(film)
    }

    public func getAllFavorites() async throws -> [FilmDTO] {
        try await localDataSource.getAll()
    }
}
