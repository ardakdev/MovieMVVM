// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailViewModelProtocol {
    var movieDetails: Movie? { get set }
    var updateDetails: ((DetailViewModelProtocol) -> ())? { get set }
    var moviAPIService: MoviAPIServiceProtocol? { get set }
    func loadMovieDetails(movieID: Int)
}

final class DetailViewModel: DetailViewModelProtocol {
    var moviAPIService: MoviAPIServiceProtocol?
    var updateDetails: ((DetailViewModelProtocol) -> ())?
    var movieDetails: Movie? {
        didSet {
            updateDetails?(self)
        }
    }

    func loadMovieDetails(movieID: Int) {
        moviAPIService?.featchDetails(movieID: movieID, completionHandler: { [weak self] result in
            switch result {
            case let .success(movieDetails):
                self?.movieDetails = movieDetails
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}
