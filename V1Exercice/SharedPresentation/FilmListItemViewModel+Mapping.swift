//
//  FilmListItemViewModel+Mapping.swift
//  V1Exercice
//

import SwiftUI
import Domain

extension FilmListItemViewModel {
    static func convert<Details: View>(_ films: [Film], details: @escaping (_ film: FilmDetailsViewModel) -> Details) -> [FilmListItemViewModel<Details>] {
        films.map {
            convert($0, details: details)
        }
    }

    static func convert<Details: View> (_ film: Film, details: @escaping (_ film: FilmDetailsViewModel) -> Details) -> FilmListItemViewModel<Details> {
        FilmListItemViewModel<Details>(
            title: "\(film.id). \"\(film.title)\"",
            destination: {
                details(convert(film))
            })
    }

    static func convert(_ film: Film) -> FilmDetailsViewModel {
        FilmDetailsViewModel(title: film.title,
                             description: film.description)
    }
}
