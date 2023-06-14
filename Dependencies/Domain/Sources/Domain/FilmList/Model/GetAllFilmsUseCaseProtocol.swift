//
//  GetAllFilmsUseCaseProtocol.swift
//

import Foundation

public protocol GetAllFilmsUseCaseProtocol {
    func perform() async throws -> [Film]
}
