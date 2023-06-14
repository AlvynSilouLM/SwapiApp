//
//  FilmListItemView.swift
//  V1Exercice
//
//

import Domain
import EnkiDesignSystem
import SwiftUI

public struct FilmListItemView: View {
    let film: Film

    var title: String {
        film.title
    }

    public var body: some View {
        LabelCell(label: title)
    }
}

