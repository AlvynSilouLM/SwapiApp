//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI

struct FilmNavigationView: View {
    @ObservedObject var filmListLoaderVM: FilmAppNavigationViewModel = FilmAppNavigationViewModel()

    var filmsViewModels: [FilmListItemViewModel<FilmDetailsView>] {
        FilmListItemViewModel<FilmDetailsView>.convert(
            filmListLoaderVM.films,
            details: { film in
                FilmDetailsView(viewModel: film)
        })
    }

    var body: some View {
        NavigationView {
            FilmsListView(films: .constant(filmsViewModels))
                .navigationBarTitle(Text("Films"))
        }.task {
            await filmListLoaderVM.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var films: [Film] = []
    
    static var previews: some View {
        FilmNavigationView(filmListLoaderVM: FilmAppNavigationViewModel())
    }
}
