//
//  SplashViewModel.swift
//  manu
//
//  Created by Erick Valdez on 25/04/25.
//

import Foundation

protocol SplashViewModelProtocol {
    func onViewDidLoad()
}

final class SplashViewModel: SplashViewModelProtocol {
    func onViewDidLoad() {
        print("APP ->", "ViewModel did load")
    }
}
