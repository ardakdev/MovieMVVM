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
    var imageApiService: ImageAPIServiceProtocol?
    var router: CoordinatorProtocol?

    var updateDetails: ((DetailViewModelProtocol) -> ())?
    var movieDetails: Movie? {
        didSet {
            updateDetails?(self)
        }
    }

    init(
        moviAPIService: MoviAPIServiceProtocol,
        imageApiService: ImageAPIServiceProtocol,
        router: CoordinatorProtocol,
        movieID: Int
    ) {
        self.imageApiService = imageApiService
        self.moviAPIService = moviAPIService
        self.router = router
        loadMovieDetails(movieID: movieID)
    }

    func loadMovieDetails(movieID: Int) {
        moviAPIService?.featchDetails(movieID: movieID, completionHandler: { [weak self] result in
            switch result {
            case var .success(movieDetailsWithData):

                self?.imageApiService?.featchPosterData(
                    posterPath: movieDetailsWithData.posterPath,
                    completionHandler: { [weak self] result in
                        switch result {
                        case let .success(imageData):
                            movieDetailsWithData.posterData = imageData
                            self?.movieDetails = movieDetailsWithData
                        case let .failure(error):
                            print(error)
                        }
                    }
                )

            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}
