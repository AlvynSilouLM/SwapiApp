//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI
import Domain

struct FilmNavigationView: View {
    @ObservedObject var filmListLoaderVM: FilmAppNavigationViewModel

    var filmsViewModels: [FilmListItemViewModel<FilmDetailsView>] {
        filmListLoaderVM.films.map { film in
            FilmListItemViewModel<FilmDetailsView>.convert(
                film,
                isFavorite: false,
                details: { filmViewModel in
                    filmDetailWith(filmViewModel) {
                        return await filmListLoaderVM.setFavorite(film)
                    }
                }
            )}
    }

    var filmsFavoritesViewModels: [FilmListItemViewModel<FilmDetailsView>] {
        filmListLoaderVM.favoritesFilms.map { film in
            FilmListItemViewModel<FilmDetailsView>.convert(
                film,
                isFavorite: true,
                details: { filmViewModel in
                    filmDetailWith(filmViewModel) {
                        return await filmListLoaderVM.setFavorite(film)
                    }
                }
            )}
    }

    var body: some View {
        NavigationView {
            TabView {
                FilmsListView(films: .constant(filmsViewModels))
                    .tabItem {
                        Label("Films", systemImage: "film")
                    }
                    .navigationBarTitle(Text("Films"))

                FilmFavoritesView(films: .constant(filmsFavoritesViewModels))
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }.task {
                        await filmListLoaderVM.getAllFavorites()
                    }
            }

        }.task {
            await filmListLoaderVM.load()
        }
    }

    @ViewBuilder
    fileprivate func filmDetailWith(_ filmViewModel: FilmDetailsViewModel, onFavoriteButtonTapped: @escaping () async -> FilmDetailsViewModel) -> FilmDetailsView {
        FilmDetailsView(viewModel: filmViewModel,
                               onFavoriteButtonTapped: onFavoriteButtonTapped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var films: [Film] = []
    
    static var previews: some View {
        FilmNavigationView(filmListLoaderVM: FilmAppNavigationViewModel(getFilmListUseCase: NullGetFilmListUseCase(), setFilmFavoriteUseCase: NullSetFavoriteFilmUseCase(), getFavoritesFilmsUseCase: NullGetFavoriteFilmListUseCase()))
    }
}
