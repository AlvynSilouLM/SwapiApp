//
//  FilmFavoritesViewModel.swift
//  V1Exercice
//

import Foundation
import Domain

public final class FavoritesFilmListViewModel: ObservableObject {
    @Published var favoritesFilms: [Film] = []

    private var getFavoritesFilmsUseCase: GetFavoriteFilmListUseCaseProtocol

    public init(getFavoritesFilmsUseCase: GetFavoriteFilmListUseCaseProtocol) {
        self.getFavoritesFilmsUseCase = getFavoritesFilmsUseCase
    }

    func getAllFavorites() async {
        do {
            favoritesFilms = try await getFavoritesFilmsUseCase.perform()
        } catch {

        }
    }
}
