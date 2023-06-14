//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

import Domain
import EnkiDesignSystem
import SwiftUI

struct FilmsListView: View {
    @ObservedObject var viewModel: FilmsListViewModel
    
    var body: some View {
        EnkiList {
            ForEach($viewModel.films, id: \.self) { film in
                NavigationLink(destination: filmDetailWith(film)) {
                    cell(for: film.wrappedValue)
                }
            }
            .listRowSeparator(.hidden)
        }
        .task {
            await viewModel.loadAllFilms()
        }
        .overlay {
            if viewModel.films.isEmpty {
                Spinner()
            }
        }

    }
    
}

private func filmDetailWith(_ film: Binding<Film>) -> some View {
    FilmDetailsView(viewModel: FilmDetailsViewModel(film: film))
}

private func cell(for film: Film) -> some View {
    FilmListItemView(film: film)
}
