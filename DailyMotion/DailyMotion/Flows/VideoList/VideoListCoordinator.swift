//
//  VideoListCoordinator.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

final class VideoListCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let factory: VideoListFactoryProtocol

    init(navigationController: UINavigationController, factory: VideoListFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start() {
        let viewController = factory.makeVideoListViewController(delegate: self)
        navigationController.pushViewController(viewController, animated: false)
    }

    private func openDetailsScreen(title: String, urlString: String) {
        guard let url = URL(string: urlString) else {
            assertionFailure("Cannot create url from \(urlString)")
            return
        }
        let viewController = factory.makeVideoViewController(title: title, url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension VideoListCoordinator: VideoListViewControllerDelegate {
    func videoListViewControllerDidSelectVideo(_ sender: UIViewController, title: String, urlString: String) {
        openDetailsScreen(title: title, urlString: urlString)
    }
}
