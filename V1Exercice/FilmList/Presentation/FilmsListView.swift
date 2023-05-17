//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

struct FilmsListView: View {
    @State var films: [FilmListItemViewModel] = []

    var body: some View {

        if films.isEmpty {
            Spinner()
        } else {
            EnkiList {
                ForEach(films, id: \.self) { film in
                    cell(for: film)
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
    static var previews: some View {
        Group {
            FilmsListView()
                .padding()
                .previewDisplayName("Loading State or Empty State")

            FilmsListView(films: [" 3. \"A New Faith\"", "4. \"A New Hope\""])
                .padding()
                .previewDisplayName("Films List")
        }
    }
}
