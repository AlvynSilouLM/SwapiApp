//
//  Film.swift
//  V1ExerciceTests
//

import Foundation

public struct Film {
    public let id: String
    public let title: String
    public let description: String
    
    public init(id: String, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
