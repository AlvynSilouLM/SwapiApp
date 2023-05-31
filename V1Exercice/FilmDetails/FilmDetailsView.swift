//
//  FilmDetailsView.swift
//  V1Exercice
//

import SwiftUI

struct FilmDetailsView: View {
    var viewModel: FilmDetailsViewModel

    var body: some View {
        Text(viewModel.description)
            .enkiFont(.bodyMedium)
            .padding()
            .navigationTitle(.constant(viewModel.title))
    }
}

struct FilmDetailsView_Previews: PreviewProvider {
    static var viewModel = FilmDetailsViewModel(title: "Mon titre", description: "Ma description")
    static var previews: some View {
        FilmDetailsView(viewModel: viewModel)
    }
}
