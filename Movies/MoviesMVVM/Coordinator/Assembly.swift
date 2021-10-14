// Assembly.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AssemblyProtocol {
    func createMainScreen(router: CoordinatorProtocol) -> UIViewController
    func createDetailsScreen(router: CoordinatorProtocol, movieID: Int) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createMainScreen(router: CoordinatorProtocol) -> UIViewController {
        let view = MovieViewController()
        let mainViewModel = MainViewModel(
            moviAPIService: MoviAPIService(),
            imageApiService: ImageAPIService(),
            router: router
        )
        view.viewModel = mainViewModel
        return view
    }

    func createDetailsScreen(router: CoordinatorProtocol, movieID: Int) -> UIViewController {
        let view = DetailViewController()
        let detailsViewModel = DetailViewModel(
            moviAPIService: MoviAPIService(),
            imageApiService: ImageAPIService(),
            router: router,
            movieID: movieID
        )

        view.detailViewModel = detailsViewModel
        return view
    }
}
