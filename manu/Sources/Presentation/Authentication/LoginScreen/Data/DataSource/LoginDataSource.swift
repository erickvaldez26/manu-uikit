//
//  LoginDataSource.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Combine
import FirebaseAuth

protocol LoginDataSource: AnyObject {
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult?
}

class LoginDataSourceImpl: LoginDataSource, ConnectivityChecking {
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        return try await withConnectivity {
            try await Auth.auth().signIn(withEmail: email, password: password)
        }
    }
}
