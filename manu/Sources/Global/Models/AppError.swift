//
//  AppError.swift
//  manu
//
//  Created by Erick Valdez on 4/10/25.
//

enum AppError: Error {
    case generic(message: String?)
    case noInternet
    case noAuthenticated
}
