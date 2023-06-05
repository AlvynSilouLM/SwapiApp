//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

struct FilmsListView<Details : View>: View {
    @Binding var films: [FilmListItemViewModel<Details>]

    var body: some View {

        if films.isEmpty {
            Spinner()
        } else {
            EnkiList {
                ForEach(films, id: \.self) { film in
                    NavigationLink(destination: film.destination) {
                        cell(for: film.title)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
    }

    private func cell(for filmTitle: String) -> some View {
        FilmListItemView(title: filmTitle)
    }
}

struct FilmsListView_Previews: PreviewProvider {
    @State static var films: [FilmListItemViewModel<Text>] = []
    @State static var films2: [FilmListItemViewModel<Text>] = [.init(title: " 3. \"A New Faith\"", destination: {
        Text("Ici Details")
    } )]

    static var previews: some View {
        Group {
            FilmsListView<Text>(films: $films)
                .padding()
                .previewDisplayName("Loading State or Empty State")
            FilmsListView<Text>(films: $films2)
                .padding()
                .previewDisplayName("Films List")
        }
    }
}
