//
//  AuthenticationCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

protocol AuthenticationCoordinatorProtocol: AnyObject {
    func goToRegister()
    func presentAlertError(_ error: MNRequestError)
    func popupController()
}

final class AuthenticationCoordinator: Coordinator, AuthenticationCoordinatorProtocol {
    var navigationController: UINavigationController
    private let alertBuilder: MNAlertBuilderProtocol
    private unowned let parentCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator, alertBuilder: MNAlertBuilderProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.alertBuilder = alertBuilder
    }
    
    func start() {
        let viewController = LoginScreenFactory.createViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func goToRegister() {
        let viewController = RegisterScreenFactory.createViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentAlertError(_ error: MNRequestError) {
        guard let topViewController = navigationController.topViewController else { return }
        alertBuilder.buildError(
            type: .alert,
            title: "Sin conexión a Internet",
            message: "Por favor, verifica tu conexión y vuelve a intentarlo",
            actionMessage: "Entiendo",
            viewController: topViewController
        )
    }
    
    func popupController() {
        navigationController.popViewController(animated: true)
    }
}
