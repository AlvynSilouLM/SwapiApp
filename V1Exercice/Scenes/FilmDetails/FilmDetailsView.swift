//
//  FilmDetailsView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

struct FilmDetailsView: View {
    var viewModel: FilmDetailsViewModel

    @State var isFavorite: Bool = false

    @State var feedback: String?

    var onFavoriteButtonTapped: (() -> Void)?

    var body: some View {
        Text(viewModel.description)
            .enkiFont(.bodyMedium)
            .padding()
            .toolbar(content: toolBarContent)
            .navigationTitle(viewModel.title)
            .overlay(alignment: .bottom) {
                if let feedback {
                    SnackbarView(message: feedback) {

                    }
                }
            }
    }

    func toolBarContent() -> some ToolbarContent {
        let favoriteIcon = Image(asset: EnkiAssets.Icons.icFavorite)
        return Group {
            ToolbarItem {
                EnkiButton(style: .secondary, iconType: .alone(image: favoriteIcon)) {
                    onFavoriteButtonTapped?()
                    if isFavorite {
                        feedback = "Ajouté aux favoris"
                    }
                }
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
