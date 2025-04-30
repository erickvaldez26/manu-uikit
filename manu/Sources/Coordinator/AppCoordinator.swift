//
//  AppCoordinator.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func goToAuthentication()
    func goToTabBarController()
}

final class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    var navigationController: UINavigationController
    private var splashCoordinator: SplashCoordinator?
    private var authenticationCoordinator: AuthenticationCoordinator?
//    private var mainTabBarCoordinator: MainTabBarCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let splash = SplashCoordinator(navigationController: navigationController, parentCoordinator: self)
        self.splashCoordinator = splash
        splash.start()
    }
    
    func goToAuthentication() {
        let authentication = AuthenticationCoordinator(navigationController: navigationController, parentCoordinator: self, alertBuilder: MNAlertBuilder())
        self.authenticationCoordinator = authentication
        self.splashCoordinator = nil
        authentication.start()
    }
    
    func goToTabBarController() {
        let tabBar = MainTabBarCoordinator(navigationController: navigationController)
//        self.mainTabBarCoordinator = tabBar
        self.splashCoordinator = nil
        self.authenticationCoordinator = nil
        tabBar.start()
    }
}
