// MoviesMVVMTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVVM
import XCTest

final class MockNavigationController: UINavigationController {
    var presented: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presented = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

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
