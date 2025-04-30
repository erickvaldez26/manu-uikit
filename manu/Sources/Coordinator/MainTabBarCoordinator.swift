//
//  MainTabBarCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var tabBarController: MNTabBarController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController = MNTabBarController()
        
        let homeNav = UINavigationController()
        let calculatorNav = UINavigationController()
        
        let homeTab = HomeTabCoordinator(navigationController: homeNav)
        let calculatorTab = CalculatorTabCoordinator(navigationController: calculatorNav)
        
        homeTab.start()
        calculatorTab.start()
        
        tabBarController.setViewControllers([homeTab.navigationController, calculatorTab.navigationController])
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
}
