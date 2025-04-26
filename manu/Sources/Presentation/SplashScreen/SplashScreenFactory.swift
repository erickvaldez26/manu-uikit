//
//  SplashScreenFactory.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

struct SplashScreenFactory {
    static func createViewController(coordinator: SplashCoordinator) -> SplashViewController {
        SplashViewController(viewModel: createViewModel(), coordinator: coordinator)
    }
    
    private static func createViewModel() -> SplashViewModelProtocol {
        SplashViewModel()
    }
}
