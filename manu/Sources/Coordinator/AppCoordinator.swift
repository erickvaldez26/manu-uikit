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
    
    private var overlayView: MNOverlayFSView?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
        
        setupErrorHandling()
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
    
    private func setupErrorHandling() {
        GlobalErrorHandler.shared.onError = { [weak self] appErr in
            self?.showOverlay(for: appErr)
        }
    }
    
    private func showOverlay(for error: AppError) {
        if overlayView != nil {
            return
        }
        
        guard let window = UIApplication.shared.currentKeyWindow else {
            return
        }
        
        let nib = UINib(nibName: "MNOverlayFSView", bundle: nil)
        let overlay = nib.instantiate(withOwner: nil, options: nil).first as! MNOverlayFSView
        overlay.configure(
            state: error,
            message: "Test In Coordinator Show",
            primaryTextButton: nil,
            secondaryTextButton: nil
        )
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(overlay)
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: window.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])
        
        self.overlayView = overlay
    }
    
    func hideOverlay() {
        guard let overlay = overlayView else { return }
        UIView.animate(withDuration: 0.2) {
            overlay.alpha = 0
        } completion: { _ in
            overlay.removeFromSuperview()
        }
        overlayView = nil
    }
    
}

extension UIApplication {
    var currentKeyWindow: UIWindow? {
        if #available(iOS 15, *) {
            return self.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return self.windows.first { $0.isKeyWindow }
        }
    }
}
