// AssemblyTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class AssemblyTests: XCTestCase {
    var assembly: AssemblyProtocol!
    var router: CoordinatorProtocol!

    override func setUpWithError() throws {
        assembly = Assembly()
        router = Coordinator(navigationController: MockNavigationController(), assembly: assembly)
    }

    override func tearDownWithError() throws {
        assembly = nil
    }

    func testMovieScreen() throws {
        let movieScreen = assembly.createMainScreen(router: router)
        XCTAssertTrue(movieScreen is MovieViewController)
    }

    func testDetailsScreen() throws {
        let detailsScreen = assembly.createDetailsScreen(router: router, movieID: 12345)
        XCTAssertTrue(detailsScreen is DetailViewController)
    }
}
