//
//  SetFavoriteUseCaseProtocol.swift
//

import Foundation

public protocol SetFavoriteUseCaseProtocol {
    func perform(_ film: Film) async throws -> Bool
}
