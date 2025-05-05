//
//  HomeTabCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

protocol HomeTabCoordinatorProtocol: AnyObject {}

final class HomeTabCoordinator: Coordinator, HomeTabCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeScreenFactory.createViewController(coordinator: self)
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
