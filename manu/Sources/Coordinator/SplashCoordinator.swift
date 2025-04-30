//
//  SplashCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

protocol SplashCoordinatorProtocol: AnyObject {
    func goToAuthentication()
    func goToTabBarController()
}

final class SplashCoordinator: Coordinator, SplashCoordinatorProtocol {
    var navigationController: UINavigationController
    private unowned let parentCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewController = SplashScreenFactory.createViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func goToAuthentication() {
        parentCoordinator.goToAuthentication()
    }
    
    func goToTabBarController() {
        parentCoordinator.goToTabBarController()
    }
}
