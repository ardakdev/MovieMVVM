// Coordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol CoordinatorMain {
    var navigationController: UINavigationController? { get set }
    var assembly: AssemblyProtocol? { get set }
}

protocol CoordinatorProtocol: CoordinatorMain {
    func initialViewController()
    func showDetails(movieID: Int)
}

final class Coordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?

    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }

    func initialViewController() {
        guard let navigationController = navigationController,
              let mainViewController = assembly?.createMainScreen(router: self)
        else {
            return
        }
        navigationController.viewControllers = [mainViewController]
    }

    func showDetails(movieID: Int) {
        guard let navigationController = navigationController,
              let detailsViewController = assembly?.createDetailsScreen(router: self, movieID: movieID)
        else {
            return
        }
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
