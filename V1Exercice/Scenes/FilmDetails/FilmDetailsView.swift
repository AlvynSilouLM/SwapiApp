//
//  FilmDetailsView.swift
//  V1Exercice
//

import SwiftUI
import EnkiDesignSystem

struct FilmDetailsView: View {
    @State var viewModel: FilmDetailsViewModel
    @State var isFeedbackPresented: Bool = false

    var onFavoriteButtonTapped: (() async -> FilmDetailsViewModel)?

    var body: some View {
        Text(viewModel.description)
            .enkiFont(.bodyMedium)
            .padding()
            .toolbar(content: toolBarContent)
            .navigationTitle(viewModel.title)
            .overlay(alignment: .bottom) {
                if isFeedbackPresented,
                   let feedback = viewModel.feedback {
                    SnackbarView(message: feedback) {
                        self.isFeedbackPresented = false
                    }
                }
            }
    }

    func toolBarContent() -> some ToolbarContent {
        let favoriteIcon = viewModel.isFavorite ? Image(systemName: "heart.fill") : Image(asset: EnkiAssets.Icons.icFavorite)
        return Group {
            ToolbarItem {
                EnkiButton(style: .primary, iconType: .alone(image: favoriteIcon)) {
                    Task {
                        if let onFavoriteButtonTapped {
                            viewModel = await onFavoriteButtonTapped()
                            isFeedbackPresented = true
                        }
                    }
                }.enkiBackgroundColor(.absolute(.white))
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
