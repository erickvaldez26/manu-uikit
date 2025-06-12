//
//  LoginRepository.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Combine
import FirebaseAuth

class LoginRepositoryImpl: LoginRepository {
    private let dataSource: LoginDataSource
    
    init(dataSource: LoginDataSource) {
        self.dataSource = dataSource
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        return try await dataSource.signInWithEmail(email: email, password: password)
    }
}
