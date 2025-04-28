//
//  LoginRepositoryProtocol.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Combine
import FirebaseAuth

protocol LoginRepository: AnyObject {
    func signInWithEmail(email: String, password: String) async -> Result<AuthDataResult?, Error>
}
