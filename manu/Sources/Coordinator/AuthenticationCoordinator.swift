//
//  AuthenticationCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

protocol AuthenticationCoordinatorProtocol: AnyObject {
    func goToRegister()
}

final class AuthenticationCoordinator: Coordinator, AuthenticationCoordinatorProtocol {
    var navigationController: UINavigationController
    private unowned let parentCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewController = LoginScreenFactory.createViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func goToRegister() {
        print("APP ->", "Go to register")
    }
}
