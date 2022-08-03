//
//  AppCoordinator.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let factory: AppFactoryProtocol
    private var childCoordinators: [Coordinator] = []

    init(window: UIWindow, factory: AppFactoryProtocol) {
        self.window = window
        self.factory = factory
    }

    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let videoListCoordinator = factory.makeVideoListCoordinator(navigationController: navigationController)
        childCoordinators.append(videoListCoordinator)
        videoListCoordinator.start()
    }
}
