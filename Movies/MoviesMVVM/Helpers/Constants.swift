// Constants.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Константы URL path
enum Constants {
    static let popular =
        "https://api.themoviedb.org/3/movie/popular?api_key=d2d80f74ec43fc7ba2e4415c6713d125&language=ru-RU&page=1"
    static let topRates =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=d2d80f74ec43fc7ba2e4415c6713d125&language=ru-RU&page=1"
    static let topComing =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=d2d80f74ec43fc7ba2e4415c6713d125&language=ru-Ru&page=1"
    static let imageCatalog = "https://image.tmdb.org/t/p/w500"
}
