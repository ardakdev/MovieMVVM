// DetailsViewModelTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailViewModelProtocol!
    var movieAPIService: MovieAPIServiceProtocol!
    var imageAPI: ImageAPIServiceProtocol!
    var router: CoordinatorProtocol!
    var assembly: AssemblyProtocol!

    override func setUpWithError() throws {
        movieAPIService = MockMoviApiService()
        imageAPI = MockImageApiService()
        assembly = Assembly()
        router = Coordinator(navigationController: MockNavigationController(), assembly: assembly)
        viewModel = DetailViewModel(
            moviAPIService: movieAPIService,
            imageApiService: imageAPI,
            router: router,
            movieID: 1234
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
        movieAPIService = nil
        imageAPI = nil
        router = nil
        assembly = nil
    }

    func testExample() throws {
        viewModel?.loadMovieDetails(movieID: 1234)
        XCTAssertNotNil(viewModel.movieDetails == nil)
    }
}
