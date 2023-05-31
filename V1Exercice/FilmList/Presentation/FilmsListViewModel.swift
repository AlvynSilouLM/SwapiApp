//
//  FilmsListViewModel.swift
//  V1Exercice
//

import Foundation

public struct FilmListItemViewModel<DestinationView> {
    let title: String
    let destination: () -> DestinationView
}

extension FilmListItemViewModel: Hashable {
    public static func == (lhs: FilmListItemViewModel<DestinationView>, rhs: FilmListItemViewModel<DestinationView>) -> Bool {
        return lhs.title == rhs.title
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
