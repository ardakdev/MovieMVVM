// MainViewModelTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModelProtocol!
    var movieAPIService: MovieAPIServiceProtocol!
    var imageAPI: ImageAPIServiceProtocol!
    var repository: RepositoryProtocol!
    var router: CoordinatorProtocol!
    var assembly: AssemblyProtocol!

    override func setUpWithError() throws {
        movieAPIService = MockMoviApiService()
        imageAPI = MockImageApiService()
        assembly = Assembly()
        router = Coordinator(navigationController: MockNavigationController(), assembly: assembly)
        viewModel = MainViewModel(moviAPIService: movieAPIService, imageApiService: imageAPI, router: router)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        movieAPIService = nil
        imageAPI = nil
        repository = nil
        router = nil
        assembly = nil
    }

    func testExample() throws {
        viewModel?.loadMoviesList(urlString: Constants.popular, category: 0)
        guard let result = viewModel.movies?.results else { return }
        XCTAssertTrue(!result.isEmpty)
    }
}
