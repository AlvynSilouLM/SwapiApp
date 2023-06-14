//
//  FilmDetailsView.swift
//  V1Exercice
//

import Domain
import EnkiDesignSystem
import SwiftUI

struct FilmDetailsView: View {
    @ObservedObject var viewModel: FilmDetailsViewModel

    var body: some View {
        Text(viewModel.description)
            .enkiFont(.bodyMedium)
            .padding()
            .toolbar(content: toolBarContent)
            .navigationTitle(viewModel.title)
            .overlay(alignment: .bottom) {
                if let feedback = viewModel.feedback {
                    SnackbarView(message: feedback) { }
                }
            }
    }

    func toolBarContent() -> some ToolbarContent {
        let favoriteIcon = viewModel.isFavorite ? Image(systemName: "heart.fill") : Image(asset: EnkiAssets.Icons.icFavorite)
        return Group {
            ToolbarItem {
                EnkiButton(style: .primary, iconType: .alone(image: favoriteIcon)) {
                    Task {
                        await viewModel.setFavorite()
                    }
                }.enkiBackgroundColor(.absolute(.white))
                .padding()
            }
        }
    }
}

struct FilmDetailsView_Previews: PreviewProvider {
    static var film: Film = Film(id: 5, title: "Mon titre de film", description: "Ma decription")
    static var viewModel = FilmDetailsViewModel(film: .constant(film))
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
