//
//  V1ExerciceApp.swift
//  V1Exercice
//

import SwiftUI
import Domain
import Data

@main
struct V1ExerciceApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            FilmNavigationView(filmListLoaderVM: FilmAppNavigationViewModel(filmListLoader: appDelegate.getFilmListUsecase))
        }
    }
}
