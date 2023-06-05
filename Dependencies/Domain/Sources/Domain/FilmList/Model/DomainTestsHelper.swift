//
//  DomainTestsHelper.swift
//

import Data

#if DEBUG
public extension Film {
    static func stub(id: Int = Int.random(in: 1...1000000),
                     title: String = "Film title",
                     description: String = "Film Description") -> (model: Film, dto: FilmDTO) {
        let model = Film(id: id, title: title, description: description)
        let data = FilmDTO.stub(id: id, title: title, description: description)

        return (model, data.dto)
    }
}
#endif
