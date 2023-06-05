//
//  Film.swift
//

import Foundation

public struct Film: Equatable {
    public let id: Int
    public let title: String
    public let description: String
    
    public init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
