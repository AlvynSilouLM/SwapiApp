//
//  FilmAppNavigationViewModel.swift
//  V1Exercice
//

import Foundation
import Domain
import Data

@MainActor
class FilmAppNavigationViewModel: ObservableObject {
    @Published var getFilmListUseCase: GetAllFilmsUseCaseProtocol?

    @Published var films: [Film] = []

    convenience init(filmListLoader: GetAllFilmsUseCaseProtocol) {
        self.init()
        self.getFilmListUseCase = filmListLoader
    }

    func load() async {
        do {
            films = try await getFilmListUseCase?.perform() ?? []
            print("Films COunt: \(films.count)")
        } catch {
            print(error)
        }
    }
}
