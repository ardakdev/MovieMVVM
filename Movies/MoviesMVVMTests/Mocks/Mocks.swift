// Mocks.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class MockNavigationController: UINavigationController {
    var presented: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presented = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

/// MovieAPIServiceProtocol
final class MockMoviApiService: MovieAPIServiceProtocol {
    func fetchMoviesList(
        urlString: String,
        category: Int,
        completionHandler: @escaping (Result<MoviesPage, Error>) -> Void
    ) {
        var moviePage = MoviesPage()
        var movie = Movie()
        movie.id = 0
        movie.title = "Baz"
        movie.overview = "Bar"
        movie.posterPath = "BazBar"
        movie.releaseDate = "01.11.2021"
        movie.voteAverage = 7.7
        moviePage.page = 1
        moviePage.results.append(movie)
        completionHandler(.success(moviePage))
    }

    func fetchDetails(movieID: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        var movie = Movie()
        movie.id = 0
        movie.title = "Baz"
        movie.overview = "Bar"
        movie.posterPath = "BazBar"
        movie.releaseDate = "01.11.2021"
        movie.voteAverage = 7.7
        completionHandler(.success(movie))
    }
}

final class MockImageApiService: ImageAPIServiceProtocol {
    func fetchPosterData(posterPath: String?, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        let data = Data()
        completionHandler(.success(data))
    }
}
