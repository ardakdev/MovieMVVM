// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные о фильме
struct Movie: Decodable {
    /// ID фильма
    var id: Int? = 0
    /// Название фильма
    var title: String? = ""
    /// Описание фильма
    var overview: String? = ""
    /// Дата выхода
    var releaseDate: String? = ""
    /// URL постера фильма
    var posterPath: String? = ""
    /// Рейтинг фильма
    var voteAverage: Double? = 0.0
    /// Постер в формате дата
    var posterData: Data? = nil

    init(moviesRealmObject: MovieRealm) {
        id = moviesRealmObject.id
        title = moviesRealmObject.title
        overview = moviesRealmObject.overview
        releaseDate = moviesRealmObject.releaseDate
        posterPath = moviesRealmObject.posterPath
        voteAverage = moviesRealmObject.voteAverage
        posterData = nil
    }

    init(movieDetailsRealmObject: MovieDetailsRealm) {
        id = movieDetailsRealmObject.id
        title = movieDetailsRealmObject.title
        overview = movieDetailsRealmObject.overview
        posterPath = movieDetailsRealmObject.posterPath
        releaseDate = nil
        voteAverage = nil
        posterData = nil
    }

    init() {}
}

/// Страница с фильмами
struct MoviesPage: Decodable {
    /// Номер страницы
    var page: Int? = 0
    /// Список фильмов с данными о нем
    var results: [Movie] = []

    init(movies: [Movie]) {
        page = 0
        results = movies
    }

    init() {}
}

/// Данные о фильме для Realm
@objcMembers
final class MovieRealm: Object {
    /// ID фильма
    dynamic var id = 0
    /// Название фильма
    dynamic var title: String? = ""
    /// Описание фильма
    dynamic var overview: String? = ""
    /// Дата выхода
    dynamic var releaseDate: String? = ""
    /// URL постера фильма
    dynamic var posterPath: String? = ""
    /// Рейтинг фильма
    dynamic var voteAverage = 0.0
    dynamic var category = 0
}

/// Данные о фильме для Realm
@objcMembers
final class MovieDetailsRealm: Object {
    /// ID фильма
    dynamic var id = 0
    /// Название фильма
    dynamic var title: String? = ""
    /// Описание фильма
    dynamic var overview: String? = ""
    /// URL постера фильма
    dynamic var posterPath: String? = ""
}
