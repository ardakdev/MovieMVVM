// MoviAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MoviAPIServiceProtocol {
    func fetchMoviesList(urlString: String, completionHandler: @escaping (Result<MoviesPage, Error>) -> Void)
    func featchDetails(movieID: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}

final class MoviAPIService: MoviAPIServiceProtocol {
    func fetchMoviesList(urlString: String, completionHandler: @escaping (Result<MoviesPage, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(MoviesPage.self, from: data)
                completionHandler(.success(movies))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }

    func featchDetails(movieID: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        let movieURL =
            "https://api.themoviedb.org/3/movie/\(movieID)?api_key=d2d80f74ec43fc7ba2e4415c6713d125&language=ru-RU"
        guard let url = URL(string: movieURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieDetails = try decoder.decode(Movie.self, from: data)
                completionHandler(.success(movieDetails))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
