// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные о фильме
struct Movie: Decodable {
    /// ID фильма
    let id: Int?
    /// Название фильма
    let title: String?
    /// Описание фильма
    let overview: String?
    /// Дата выхода
    let releaseDate: String?
    /// URL постера фильма
    let posterPath: String?
    /// Рейтинг фильма
    let voteAverage: Double?
}

/// Страница с фильмами
struct MoviesPage: Decodable {
    /// Номер страницы
    let page: Int?
    /// Список фильмов с данными о нем
    let results: [Movie]
}
