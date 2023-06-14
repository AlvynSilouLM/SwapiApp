//
//  FilmDetailsViewModel.swift
//  V1Exercice
//

import Foundation
import Domain
import SwiftUI

public final class FilmDetailsViewModel: ObservableObject {
    private var film: Binding<Film>

    private var setFavoriteUseCase: SetFavoriteUseCaseProtocol

    public init(film: Binding<Film>,
                setFavoriteUseCase: SetFavoriteUseCaseProtocol = SetFavoriteUseCase()) {
        self.film = film
        self.setFavoriteUseCase = setFavoriteUseCase
    }

    public func setFavorite() async {
        isFavorite = (try? await setFavoriteUseCase.perform(film.wrappedValue)) ?? false
        feedback = isFavorite ? "Ajouté aux favoris" : "Retiré des favoris"

    }
    
    public var title: String {
        film.wrappedValue.title
    }

    public var description: String {
        film.wrappedValue.description
    }

    @Published
    public var isFavorite: Bool = false

    public var feedback: String?

}
