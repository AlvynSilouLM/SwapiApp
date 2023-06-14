//
//  FilmDatabase.swift
//

import CoreData

public protocol FilmDatabaseProtocol {
    func retrieveAll() async throws -> [FilmDTO]
    func insert(_ films: [FilmDTO]) async throws
}

public actor FilmDatabase {

    private struct Cache: Codable {
        let favorites: [FilmDTO]
    }

    public static var shared: FilmDatabaseProtocol = {
        guard let databaseURL = try? FileManager.createDatabaseURL("favorites.data") else {
            return NullFilmDatabaseSource()
        }

        return FilmDatabase(databaseURL: databaseURL)
    }()

    private let databaseURL: URL

    public init(databaseURL: URL) {
        self.databaseURL = databaseURL
    }
}

extension FilmDatabase: FilmDatabaseProtocol {
    public func retrieveAll() throws -> [FilmDTO] {
        guard let data = try? Data(contentsOf: databaseURL) else {
            return []
        }
        let decoder = JSONDecoder()
        let cache = try decoder.decode(Cache.self, from: data)
        return cache.favorites
    }

    public func insert(_ films: [FilmDTO]) throws {
        let encoder = JSONEncoder()
        let cache = Cache(favorites: films)
        let encoded = try encoder.encode(cache)
        try encoded.write(to: databaseURL)
    }
}

private extension FileManager {
    static func createDatabaseURL(_ databaseName: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                                                                     in: .userDomainMask,
                                                                                     appropriateFor: nil,
                                                                                     create: false)
                                       .appendingPathComponent(databaseName)
    }
}


internal class NullFilmDatabaseSource: FilmDatabaseProtocol {
    func retrieveAll() async throws -> [FilmDTO] {
        return []
    }

    func insert(_ films: [FilmDTO]) async throws {

    }
}
