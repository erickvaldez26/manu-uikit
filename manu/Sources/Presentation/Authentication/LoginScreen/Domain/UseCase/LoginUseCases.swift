//
//  LoginUseCases.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Foundation
import Combine
import FirebaseAuth

protocol LoginUseCases: AnyObject {
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult?
}

class LoginUseCasesImpl: LoginUseCases {
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        try await repository.signInWithEmail(email: email, password: password)
    }
}
