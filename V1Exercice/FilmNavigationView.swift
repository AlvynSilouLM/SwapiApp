//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI

struct FilmNavigationView: View {
    @ObservedObject var filmListLoaderVM: FilmAppNavigationViewModel = FilmAppNavigationViewModel()
    @State var films: [Film] = []

    var filmsViewModels: [FilmListItemViewModel] {
        films.map { "\($0.id). \"\($0.title)\""}
    }
    var body: some View {
        NavigationView {
            FilmsListView(films: .constant(filmsViewModels))
                .navigationBarTitle(Text("Films"))
        }.task {
            do {
                films = try await filmListLoaderVM.filmListLoader?.load() ?? []
                print("Films: \(films)")
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var films: [Film] = []
    
    static var previews: some View {
        FilmNavigationView(filmListLoaderVM: FilmAppNavigationViewModel(), films: films)
    }
}
