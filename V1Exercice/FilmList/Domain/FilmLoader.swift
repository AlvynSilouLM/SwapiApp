//
//  FilmLoader.swift
//  V1ExerciceTests
//

import Foundation

public protocol FilmLoader {
    func load() async throws -> [Film]
}
