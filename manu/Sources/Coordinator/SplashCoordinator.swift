//
//  SplashCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

protocol SplashCoordinatorProtocol: AnyObject {
    func goToAuthentication()
    func goToHome()
}

final class SplashCoordinator: Coordinator, SplashCoordinatorProtocol {
    var navigationController: UINavigationController
    var onFinish: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SplashScreenFactory.createViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func goToAuthentication() {
        onFinish?()
    }
    
    func goToHome() {
        print("APP ->", "Go to Home")
    }
}
