//
//  FilmLocalDataSource.swift
//

import Foundation

public protocol FilmLocalDataSourceProtocol {
    func getAll() async throws -> [FilmDTO]
    func setFavorite(_ film: FilmDTO) async throws -> Bool
}

public final class FilmLocalDataSource {
    private let database: FilmDatabaseProtocol

    public init(database: FilmDatabaseProtocol = FilmDatabase.shared) {
        self.database = database
    }
}

extension FilmLocalDataSource: FilmLocalDataSourceProtocol {
    public func getAll() async throws -> [FilmDTO] {
        try await database.retrieveAll()
    }

    public func setFavorite(_ film: FilmDTO) async throws -> Bool {
        var fav = try await getAll()
        let isFavorite: Bool
        if fav.contains(film) {
            fav.removeAll { $0 == film }
            isFavorite = false
        } else {
            fav.append(film)
            isFavorite = true
        }
        try await database.insert(fav)
        return isFavorite
    }
}

