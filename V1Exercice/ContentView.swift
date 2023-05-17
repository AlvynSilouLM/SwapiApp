//
//  ContentView.swift
//  V1Exercice
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            FilmsListView()
                .navigationBarTitle(Text("Films"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
