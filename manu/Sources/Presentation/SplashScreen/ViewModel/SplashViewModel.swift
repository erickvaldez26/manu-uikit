//
//  SplashViewModel.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import Foundation
import FirebaseAuth

protocol SplashViewModelProtocol {
    var isUserAuthenticated: Bool? { get }
    func onViewDidLoad()
}

final class SplashViewModel: SplashViewModelProtocol {
    var isUserAuthenticated: Bool?
    
    func onViewDidLoad() {
        isUserAuthenticated = Auth.auth().currentUser != nil
    }
}
