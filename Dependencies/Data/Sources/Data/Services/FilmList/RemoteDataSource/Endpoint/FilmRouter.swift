//
//  FilmRouter.swift
//  V1Exercice
//
//  Created by Alvyn S on 26/05/2023.
//

import Foundation

extension Router {
    public func getAllFilmRequest() throws -> URLRequest {
        try request(httpMethod: .get, path: "/api/films")
    }
}
