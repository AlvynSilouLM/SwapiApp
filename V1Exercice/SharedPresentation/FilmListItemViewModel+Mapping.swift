//
//  FilmListItemViewModel+Mapping.swift
//  V1Exercice
//

import SwiftUI
import Domain

extension FilmListItemViewModel {
    static func convert<Details: View> (_ film: Film, isFavorite: Bool, details: @escaping (_ film: FilmDetailsViewModel) -> Details) -> FilmListItemViewModel<Details> {
        FilmListItemViewModel<Details>(
            title: "\(film.id). \"\(film.title)\"",
            destination: {
                details(FilmDetailsViewModel.convert(film, isFavorite: isFavorite))
            })
    }
}

extension FilmDetailsViewModel {
    static func convert(_ film: Film, isFavorite: Bool) -> FilmDetailsViewModel {
        FilmDetailsViewModel(title: film.title,
                             description: film.description,
                             isFavorite: isFavorite,
                             feedback: isFavorite ? "Ajouté aux favoris" : "Retiré des favoris")
    }
}

