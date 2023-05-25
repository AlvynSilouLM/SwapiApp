//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI

struct FilmNavigationView: View {
    var body: some View {
        NavigationView {
            FilmsListView()
                .navigationBarTitle(Text("Films"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilmNavigationView()
    }
}
