//
//  AppDelegate.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appCoordinator = AppCoordinator()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        setupAppearance()
        appCoordinator.start()
        return true
    }

    private func setupAppearance() {
        // Set global navigationbar title style
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: Style.font(ofSize: 20.0, weight: .medium)
        ]
    }
}
