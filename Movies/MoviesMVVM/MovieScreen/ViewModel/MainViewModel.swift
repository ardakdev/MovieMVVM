// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var movies: MoviesPage? { get set }
    var imageData: Data? { get set }
    var updateViewData: ((MainViewModelProtocol?) -> ())? { get set }
    var moviAPIService: MoviAPIServiceProtocol? { get set }
    var imageApiService: ImageAPIServiceProtocol? { get set }
    func loadMoviesList(urlString: String)
    func loadImageData(posterPath: String)
}

final class MVVMViewModel: MainViewModelProtocol {
    var imageData: Data?
    var imageApiService: ImageAPIServiceProtocol?
    var moviAPIService: MoviAPIServiceProtocol?

    var movies: MoviesPage? {
        didSet {
            updateViewData?(self)
        }
    }

    var updateViewData: ((MainViewModelProtocol?) -> ())?

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
