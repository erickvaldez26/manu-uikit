//
//  AppCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var splashCoordinator: SplashCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splash = SplashCoordinator(navigationController: navigationController)
        self.splashCoordinator = splash
        splash.onFinish = { [weak self] in
            print("APP ->", "Go to authentication")
            self?.splashCoordinator = nil
        }
        splash.start()
    }
}
