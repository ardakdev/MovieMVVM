// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol {
    func saveMovies(movieList: [Movie], category: Int)
    func loadMovies(category: Int) -> MoviesPage?
    func saveMovieDetails(movieDetails: Movie)
    func loadMovieDetails(movieID: Int) -> Movie?
}

final class Repository: RepositoryProtocol {
    func saveMovies(movieList: [Movie], category: Int) {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: config) else { return }
        try? realm.write {
            for movieList in movieList {
                let realmObject = MovieRealm()
                realmObject.id = movieList.id ?? 0
                realmObject.title = movieList.title
                realmObject.overview = movieList.overview
                realmObject.releaseDate = movieList.releaseDate
                realmObject.posterPath = movieList.posterPath
                realmObject.voteAverage = movieList.voteAverage ?? 0.0
                realmObject.category = category
                realm.add(realmObject)
            }
        }
    }

    func loadMovies(category: Int) -> MoviesPage? {
        var movie: [Movie] = []

        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: config) else { return nil }

        let realmObjects = realm.objects(MovieRealm.self).filter("category == \(category)")
        realmObjects.forEach { realmObject in
            let movieItem = Movie(moviesRealmObject: realmObject)
            movie.append(movieItem)
        }

        return (movie.count > 0) ? MoviesPage(movies: movie) : nil
    }

    func saveMovieDetails(movieDetails: Movie) {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: config) else { return }
        try? realm.write {
            let realmObject = MovieDetailsRealm()
            realmObject.id = movieDetails.id ?? 0
            realmObject.title = movieDetails.title
            realmObject.overview = movieDetails.overview
            realmObject.posterPath = movieDetails.posterPath
            realm.add(realmObject)
        }
    }

    func loadMovieDetails(movieID: Int) -> Movie? {
        var movie: Movie?

        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: config) else { return nil }

        let realmObjects = realm.objects(MovieDetailsRealm.self).filter("id == \(movieID)")
        realmObjects.forEach { realmObject in
            movie = Movie(movieDetailsRealmObject: realmObject)
        }
        return movie
    }
}
