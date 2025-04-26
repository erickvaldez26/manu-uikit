//
//  AppCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
}
