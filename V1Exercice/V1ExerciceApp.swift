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

@MainActor
class FilmAppNavigationViewModel: ObservableObject {
    @Published var filmListLoader: FilmLoaderUseCase?

    @Published var films: [Film] = []

    convenience init(filmListLoader: FilmLoaderUseCase) {
        self.init()
        self.filmListLoader = filmListLoader
    }

    func load() async {
        do {
            films = try await filmListLoader?.load() ?? []
            print("Films COunt: \(films.count)")
        } catch {
            print(error)
        }
    }
}
