// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageAPIServiceProtocol {
    func featchPosterData(posterPath: String?, completionHandler: @escaping (Result<Data, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    func featchPosterData(posterPath: String?, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        guard let posterPath = posterPath else { return }
        guard let url = URL(string: posterPath) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                guard let error = error else { return }
                completionHandler(.failure(error))
                return
            }
            guard let data = data else { return }
            completionHandler(.success(data))
        }.resume()
    }
}
