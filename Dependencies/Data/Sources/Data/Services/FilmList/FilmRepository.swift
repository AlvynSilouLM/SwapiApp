//
//  FilmListRepository.swift
//  
//

import Foundation

public protocol FilmRepositoryProtocol {
    func getAll() async throws -> [FilmDTO]
}

public final class FilmRepository: FilmRepositoryProtocol {

    var remoteDataSource: FilmRemoteDataSourceProtocol

    public init(remoteDataSource: FilmRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func getAll() async throws -> [FilmDTO] {
        try await remoteDataSource.getAll()
    }
}
