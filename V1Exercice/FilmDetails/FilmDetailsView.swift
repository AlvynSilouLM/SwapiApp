//
//  FilmDetailsView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

struct FilmDetailsView: View {
    var viewModel: FilmDetailsViewModel

    var body: some View {
        Text(viewModel.description)
            .enkiFont(.bodyMedium)
            .padding()
            .toolbar(content: toolBarContent)
            .navigationTitle(.constant(viewModel.title))
    }

    func toolBarContent() -> some ToolbarContent {
        Group {
            ToolbarItem {
                Image(asset: EnkiAssets.Icons.icFavorite)
                    .padding()
            }
        }
    }
}

struct FilmDetailsView_Previews: PreviewProvider {
    static var viewModel = FilmDetailsViewModel(title: "Mon titre", description: "Ma description")
    static var previews: some View {
        Group {
            FilmDetailsView(viewModel: viewModel)
                .previewDisplayName("Without Navigation")

            NavigationView {
                FilmDetailsView(viewModel: viewModel)
                    .previewDisplayName("With Navigation")

            }

        }
    }
}
