//
//  RegisterRepository.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import Foundation
import FirebaseAuth

class RegisterRepositoryImpl: RegisterRepository {
    private let dataSource: RegisterDataSource
    
    init(dataSource: RegisterDataSource) {
        self.dataSource = dataSource
    }
    
    func registerUser(name: String, email: String, password: String) async -> Result<AuthDataResult?, Error> {
        return await dataSource.registerUser(name: name, email: email, password: password)
    }
}
