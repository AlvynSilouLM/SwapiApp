//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI
import Domain
import EnkiDesignSystem

struct FilmNavigationView: View {

    var body: some View {
        EnkiNavigationView {
            TabView {
                FilmsListView(
                    viewModel: FilmsListViewModel(
                        getFilmListUseCase: GetFilmListUseCase()
                    )
                )
                .enkiTabItem(text: "Films", image: Image(systemName: "film"))
                .navigationBarTitle(Text("Films"))

                FilmFavoritesView(
                    viewModel: FavoritesFilmListViewModel(
                        getFavoritesFilmsUseCase: GetFavoriteFilmListUseCase()
                    )
                )
                .enkiTabItem(text: "Favorites", image: Image(systemName: "heart.fill"))

            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var films: [Film] = []
    
    static var previews: some View {
        FilmNavigationView()
    }
}
