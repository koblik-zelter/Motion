//
//  AppDelegate.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    private lazy var context = Context()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window!, factory: AppFactory(context: context))
        appCoordinator?.start()

        return true
    }

}
