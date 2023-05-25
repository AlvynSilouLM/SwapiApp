//
//  V1ExerciceApp.swift
//  V1Exercice
//

import SwiftUI

@main
struct V1ExerciceApp: App {
    var httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

    @StateObject var filmListLoaderVM = FilmAppNavigationViewModel()

    var body: some Scene {
        WindowGroup {
            FilmNavigationView(filmListLoaderVM: filmListLoaderVM)
                .onAppear {
                    startApp()
                }
        }
    }

    func startApp() {
        guard let filmListRequest = try? FilmListEndpoint.get.request(baseURL: URL(string: "https://swapi.dev/")!) else {
            // Log error
            return
        }
        let filmListLoader = FilmLoaderUseCase(request: filmListRequest,
                                               httpClient: httpClient,
                                               mapper: FilmListAdapter.adapt(_:from:))
        self.filmListLoaderVM.filmListLoader = filmListLoader
    }
}


class FilmAppNavigationViewModel: ObservableObject {
    @Published var filmListLoader: FilmLoaderUseCase?

    convenience init(filmListLoader: FilmLoaderUseCase) {
        self.init()
        self.filmListLoader = filmListLoader
    }

}
