// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var movies: MoviesPage? { get set }
    var updateViewData: ((MainViewModelProtocol?) -> ())? { get set }
    var moviAPIService: MoviAPIServiceProtocol? { get set }
    func startFetch(urlString: String)
}

final class MVVMViewModel: MainViewModelProtocol {
    var moviAPIService: MoviAPIServiceProtocol?

    var movies: MoviesPage? {
        didSet {
            updateViewData?(self)
        }
    }

    var updateViewData: ((MainViewModelProtocol?) -> ())?

    func startFetch(urlString: String) {
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
