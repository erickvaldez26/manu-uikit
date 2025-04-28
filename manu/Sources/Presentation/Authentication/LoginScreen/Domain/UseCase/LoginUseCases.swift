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
    func signInWithEmail(email: String, password: String) async -> Result<AuthDataResult?, MNRequestError>
}

class LoginUseCasesImpl: LoginUseCases {
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func signInWithEmail(email: String, password: String) async -> Result<AuthDataResult?, MNRequestError> {
        let result = await repository.signInWithEmail(email: email, password: password)
        
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(MNRequestError(from: error))
        }
    }
}
