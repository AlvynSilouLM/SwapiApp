//
//  FilmFavoritesView.swift
//  V1Exercice
//

import Domain
import EnkiDesignSystem
import SwiftUI

struct FilmFavoritesView: View {
    @ObservedObject var viewModel: FavoritesFilmListViewModel

    var body: some View {
        EnkiList {
            ForEach($viewModel.favoritesFilms, id: \.self) { film in
                NavigationLink(destination: filmDetailWith(film)) {
                    cell(for: film.wrappedValue)
                }
            }
            .listRowSeparator(.hidden)
        }
        .task {
            await viewModel.getAllFavorites()
        }
        .overlay {
            if viewModel.favoritesFilms.isEmpty {
                Spinner()
            }
        }
    }

    private func filmDetailWith(_ film: Binding<Film>) -> some View {
        FilmDetailsView(viewModel: FilmDetailsViewModel(film: film))
    }

    private func cell(for film: Film) -> some View {
        FilmListItemView(film: film)
    }
}
