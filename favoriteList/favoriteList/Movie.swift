//
//  Movie.swift
//  favoriteList
//
//  Created by ALEKSANDR POZDNIKIN on 04.09.2022.
//

import Foundation

public struct Movie: Hashable {
    let title: String
    let year: Int
}

let first = Movie(title: "Interstellar", year: 2014)
let second = Movie(title: "The Shawshank Redemption", year: 1994)
