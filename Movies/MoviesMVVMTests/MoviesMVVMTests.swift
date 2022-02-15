// MoviesMVVMTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class MoviesMVVMTests: XCTestCase {
    var coordinator: CoordinatorProtocol!
    var mockNavigationController: MockNavigationController!

    override func setUpWithError() throws {
        mockNavigationController = MockNavigationController()
        coordinator = Coordinator(navigationController: mockNavigationController, assembly: Assembly())
    }

    override func tearDownWithError() throws {
        mockNavigationController = nil
        coordinator = nil
    }

    func testVC() {
        coordinator.initialViewController()
        XCTAssertTrue(mockNavigationController.viewControllers.first is MovieViewController)
    }
}
