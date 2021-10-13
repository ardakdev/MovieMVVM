// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var movies: MoviesPage? { get set }
    var test: String? { get set }
    var updateViewData: ((MainViewModelProtocol?) -> ())? { get set }

    func startFetch(urlString: String)
}

final class MVVMViewModel: MainViewModelProtocol {
    var movies: MoviesPage? {
        didSet {
            updateViewData?(self)
        }
    }

    var test: String?

    var updateViewData: ((MainViewModelProtocol?) -> ())?

    func startFetch(urlString: String) {
        test = String(Int.random(in: 1 ... 1900))
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.movies = try decoder.decode(MoviesPage.self, from: data)
                //     print(self.movies)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
