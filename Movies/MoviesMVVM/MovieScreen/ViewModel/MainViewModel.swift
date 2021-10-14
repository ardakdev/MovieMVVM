// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var imageData: Data? { get set }
    var imageApiService: ImageAPIServiceProtocol? { get set }
    var moviAPIService: MoviAPIServiceProtocol? { get set }
    var router: CoordinatorProtocol? { get set }
    var movies: MoviesPage? { get set }
    var updateViewData: ((MainViewModelProtocol?) -> ())? { get set }

    func loadMoviesList(urlString: String)
    func loadImageData(posterPath: String)
    func tapOnMovie(movieID: Int)
}

final class MainViewModel: MainViewModelProtocol {
    var imageData: Data?
    var imageApiService: ImageAPIServiceProtocol?
    var moviAPIService: MoviAPIServiceProtocol?
    var router: CoordinatorProtocol?
    var movies: MoviesPage? {
        didSet {
            updateViewData?(self)
        }
    }

    var updateViewData: ((MainViewModelProtocol?) -> ())?

    init(
        moviAPIService: MoviAPIServiceProtocol,
        imageApiService: ImageAPIServiceProtocol,
        router: CoordinatorProtocol
    ) {
        self.imageApiService = imageApiService
        self.moviAPIService = moviAPIService
        self.router = router
    }

    func tapOnMovie(movieID: Int) {
        router?.showDetails(movieID: movieID)
    }

    func loadImageData(posterPath: String) {
        imageApiService?.featchPosterData(posterPath: posterPath, completionHandler: { [weak self] result in
            switch result {
            case let .success(data):
                self?.imageData = data
            default:
                break
            }
        })
    }

    func loadMoviesList(urlString: String) {
        moviAPIService?.fetchMoviesList(urlString: urlString, completionHandler: { [weak self] result in
            switch result {
            case let .success(moviesData):
                self?.movies = moviesData
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}
