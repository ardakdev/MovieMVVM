// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    var storage: RepositoryProtocol! { get set }
    func fetchMoviesList(
        urlString: String,
        category: Int,
        completionHandler: @escaping (Result<MoviesPage, Error>) -> Void
    )
    func fetchDetails(movieID: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    var storage: RepositoryProtocol!

    init(_ storage: RepositoryProtocol) {
        self.storage = storage
    }

    func fetchMoviesList(
        urlString: String,
        category: Int,
        completionHandler: @escaping (Result<MoviesPage, Error>) -> Void
    ) {
        if let movieDetails = storage.loadMovies(category: category) {
            completionHandler(.success(movieDetails))
        } else {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movies = try decoder.decode(MoviesPage.self, from: data)
                    completionHandler(.success(movies))
                    self?.storage.saveMovies(movieList: movies.results, category: category)
                } catch {
                    completionHandler(.failure(error))
                }
            }.resume()
        }
    }

    func fetchDetails(movieID: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        if let movieDetails = storage.loadMovieDetails(movieID: movieID) {
            completionHandler(.success(movieDetails))
        } else {
            let movieURL =
                "\(Constants.movieHeadURL)\(movieID)?api_key=\(Constants.apiKey)&language=ru-RU"
            guard let url = URL(string: movieURL) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movieDetails = try decoder.decode(Movie.self, from: data)
                    completionHandler(.success(movieDetails))
                    self?.storage.saveMovieDetails(movieDetails: movieDetails)
                } catch {
                    completionHandler(.failure(error))
                }
            }.resume()
        }
    }
}
