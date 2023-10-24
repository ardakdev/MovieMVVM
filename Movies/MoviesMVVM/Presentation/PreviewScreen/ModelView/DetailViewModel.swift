// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailViewModelProtocol {
    var movieDetails: Observable<Movie?> { get set }
    // var updateDetails: ((DetailViewModelProtocol) -> ())? { get set }
    var movieAPIService: MovieAPIServiceProtocol? { get set }
    func loadMovieDetails(movieID: Int)
}

final class DetailViewModel: DetailViewModelProtocol {
    var movieAPIService: MovieAPIServiceProtocol?
    var imageApiService: ImageAPIServiceProtocol?
    var router: CoordinatorProtocol?

    // var updateDetails: ((DetailViewModelProtocol) -> ())?
//    var movieDetails: Movie? {
//        didSet {
//            updateDetails?(self)
//        }
//    }
    var movieDetails: Observable<Movie?> = Observable(nil)
    init(
        moviAPIService: MovieAPIServiceProtocol,
        imageApiService: ImageAPIServiceProtocol,
        router: CoordinatorProtocol,
        movieID: Int
    ) {
        self.imageApiService = imageApiService
        movieAPIService = moviAPIService
        self.router = router
        loadMovieDetails(movieID: movieID)
    }

    func loadMovieDetails(movieID: Int) {
        movieAPIService?.fetchDetails(movieID: movieID, completionHandler: { [weak self] result in
            switch result {
            case var .success(movieDetailsWithData):

                self?.imageApiService?.fetchPosterData(
                    posterPath: movieDetailsWithData.posterPath,
                    completionHandler: { [weak self] result in
                        switch result {
                        case let .success(imageData):
                            movieDetailsWithData.posterData = imageData
                            self?.movieDetails.value = movieDetailsWithData
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
