//
//  RegisterDataSource.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegisterDataSource: AnyObject {
    func registerUser(name: String, email: String, password: String) async -> Result<AuthDataResult?, Error>
}

class RegisterDataSourceImpl: RegisterDataSource {
    let db = Firestore.firestore()
    func registerUser(name: String, email: String, password: String) async -> Result<AuthDataResult?, Error> {
        await withCheckedContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(returning: .failure(error))
                    return
                }
                
                guard let userUID = authResult?.user.uid else {
                    continuation.resume(returning: .failure(NSError(domain: "GENERIC", code: 500)))
                    return
                }
                
                let userData: [String: Any] = [
                    "name": name,
                    "email": email
                ]
                
                self.db.collection("users").document(userUID).setData(userData) { error in
                    if let error = error {
                        continuation.resume(returning: .failure(error))
                        return
                    }
                    
                    continuation.resume(returning: .success(authResult))
                }
            }
        }
    }
}
