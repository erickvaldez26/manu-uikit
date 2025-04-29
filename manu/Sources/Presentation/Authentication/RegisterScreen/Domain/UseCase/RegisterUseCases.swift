//
//  RegisterUseCases.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import Foundation
import FirebaseAuth

protocol RegisterUseCases: AnyObject {
    func registerUser(name: String, email: String, password: String) async -> Result<RegisterModel, MNRequestError>
}

class RegisterUseCasesImpl: RegisterUseCases {
    private let repository: RegisterRepository
    
    init(repository: RegisterRepository) {
        self.repository = repository
    }
    
    func registerUser(name: String, email: String, password: String) async -> Result<RegisterModel, MNRequestError> {
        let result = await repository.registerUser(name: name, email: email, password: password)
        
        switch result {
        case .success(let data):
            let mapperRegisterModel = RegisterModel(
                uid: data?.user.uid ?? "",
                displayName: data?.user.displayName,
                username: data?.additionalUserInfo?.username,
                isNewUser: data?.additionalUserInfo?.isNewUser ?? false,
                accessToken: data?.credential?.accessToken
            )
            return .success(mapperRegisterModel)
        case .failure(let error):
            return .failure(MNRequestError(from: error))
        }
    }
}
