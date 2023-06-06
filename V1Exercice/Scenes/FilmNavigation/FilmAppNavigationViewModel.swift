//
//  FilmAppNavigationViewModel.swift
//  V1Exercice
//

import Foundation
import Domain
import Data

@MainActor
class FilmAppNavigationViewModel: ObservableObject {
    var getFilmListUseCase: GetAllFilmsUseCaseProtocol
    var setFilmFavoriteUseCase: SetFavoriteUseCaseProtocol
    var getFavoritesFilmsUseCase: GetFavoriteFilmListUseCaseProtocol

    @Published var films: [Film] = []
    @Published var favoritesFilms: [Film] = []

    init(getFilmListUseCase: GetAllFilmsUseCaseProtocol, setFilmFavoriteUseCase: SetFavoriteUseCaseProtocol, getFavoritesFilmsUseCase: GetFavoriteFilmListUseCaseProtocol) {
        self.getFilmListUseCase = getFilmListUseCase
        self.setFilmFavoriteUseCase = setFilmFavoriteUseCase
        self.getFavoritesFilmsUseCase = getFavoritesFilmsUseCase
    }

    func load() async {
        do {
            films = try await getFilmListUseCase.perform()
            print("Films COunt: \(films.count)")
        } catch {
            print(error)
        }
    }

    func setFavorite(_ film: Film) async -> FilmDetailsViewModel  {
        let filmViewModel: FilmDetailsViewModel
        do {
            let isFavorite: Bool = try await setFilmFavoriteUseCase.perform(film)
            filmViewModel = FilmDetailsViewModel.convert(film, isFavorite: isFavorite)
        } catch {
            filmViewModel = FilmDetailsViewModel.convert(film, isFavorite: false)
        }

        return filmViewModel
    }

    func getAllFavorites() async {
        do {
            favoritesFilms = try await getFavoritesFilmsUseCase.perform()
        } catch {
            
        }
    }
}
