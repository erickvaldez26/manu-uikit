//
//  CalculatorTabCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

final class CalculatorTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CalculatorViewController()
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
