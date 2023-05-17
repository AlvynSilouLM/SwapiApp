//
//  FilmListItemView.swift
//  V1Exercice
//
//

import Foundation
import SwiftUI
import EnkiDesignSystem

public struct FilmListItemView: View {
    var title: String

    public var body: some View {
        RightChevronCell {
            Text(title)
                .enkiFont(.bodyMediumHighlight)
        }
    }

}
