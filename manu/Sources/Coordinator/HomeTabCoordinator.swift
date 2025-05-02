//
//  HomeTabCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

final class HomeTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
