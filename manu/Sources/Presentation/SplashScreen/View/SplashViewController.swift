//
//  SplashViewController.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

class SplashViewController: UIViewController {
    private let viewModel: SplashViewModelProtocol
    private unowned let coordinator: SplashCoordinatorProtocol
    
    @IBOutlet weak var resourceAppImage: UIImageView!
    
    init(viewModel: SplashViewModelProtocol, coordinator: SplashCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.onViewDidLoad()
        redirectManager()
    }
    
    private func setupUI() {
        resourceAppImage.layer.cornerRadius = 10
    }
    
    private func redirectManager() {
        if let isUserAuthenticated = viewModel.isUserAuthenticated {
            if isUserAuthenticated {
                coordinator.goToTabBarController()
            } else {
                coordinator.goToAuthentication()
            }
        } else {
            coordinator.goToAuthentication()
        }
    }
}
