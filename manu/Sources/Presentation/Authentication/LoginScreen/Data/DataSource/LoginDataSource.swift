//
//  LoginDataSource.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Combine
import FirebaseAuth

protocol LoginDataSource: AnyObject {
    func signInWithEmail(email: String, password: String) async -> Result<AuthDataResult?, Error>
}

class LoginDataSourceImpl: LoginDataSource {
    func signInWithEmail(email: String, password: String) async -> Result<AuthDataResult?, Error> {
        await withCheckedContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(returning: .failure(error))
                    return
                }
                
                continuation.resume(returning: .success(authResult))
            }
        }
    }
}
