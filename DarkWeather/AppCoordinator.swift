//
//  AppCoordinator.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    init(navigationController: UINavigationController)

    func start()
}

class AppCoordinator: Coordinator {

    var window: UIWindow?

    var navigationController: UINavigationController

    required init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        showMainViewController()
    }

    func showMainViewController() {
        /// Initialize viewModel
        let viewModel = MainViewModel()

        /// Initialize viewController and inject viewModel
        let viewController = MainViewController()
        viewController.viewModel = viewModel

        /// Set viewController as rootViewController in navigationController
        navigationController.viewControllers = [viewController]
    }
}
