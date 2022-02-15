// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate запуск без Storyboard
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let fileManager = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)
        print(fileManager.description)
        let fileManager2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(fileManager2.description)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        window?.backgroundColor = .white
        let navigationController = UINavigationController()
        let assembly = Assembly()
        let router = Coordinator(navigationController: navigationController, assembly: assembly)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
