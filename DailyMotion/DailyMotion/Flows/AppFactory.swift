//
//  AppFactory.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

protocol AppFactoryProtocol {
    func makeVideoListCoordinator(navigationController: UINavigationController) -> Coordinator
}

final class AppFactory: AppFactoryProtocol {

    private let context: Context

    init(context: Context) {
        self.context = context
    }

    func makeVideoListCoordinator(navigationController: UINavigationController) -> Coordinator {
        VideoListCoordinator(navigationController: navigationController,
                             factory: VideoListFactory(context: context))
    }
}
