//
//  FilmListViewModel.swift
//  V1Exercice
//

import Foundation
import Domain

public final class FilmsListViewModel: ObservableObject {
    @Published var films: [Film] = []

    var getFilmListUseCase: GetAllFilmsUseCaseProtocol

    init(getFilmListUseCase: GetAllFilmsUseCaseProtocol) {
        self.getFilmListUseCase = getFilmListUseCase
    }

    func loadAllFilms() async {
        do {
            films = try await getFilmListUseCase.perform()
            print("Films COunt: \(films.count)")
        } catch {
            print(error)
        }
    }
}
