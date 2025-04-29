//
//  RegisterRepositoryProtocol.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import FirebaseAuth

protocol RegisterRepository: AnyObject {
    func registerUser(name: String, email: String, password: String) async -> Result<AuthDataResult?, Error>
}
