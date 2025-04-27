//
//  LoginScreenFactory.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

struct LoginScreenFactory {
    static func createViewController(coordinator: AuthenticationCoordinator) -> AuthLoginViewController {
        AuthLoginViewController()
    }
}
