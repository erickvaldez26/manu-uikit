//
//  AuthRegisterViewModel.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import Combine

class AuthRegisterViewModel: ObservableObject {
    private let useCase: RegisterUseCasesImpl
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isCheckedTermConditions: Bool = false
    @Published var stateButton: MNButton.State = .disabled
    @Published var displayRegisterSuccess: Bool = false
    @Published var displayErrorRegister: MNRequestError?
    
    init(useCase: RegisterUseCasesImpl) {
        self.useCase = useCase
    }
    
    func validateFields(name: String, email: String, password: String) {
        self.username = name
        self.email = email
        self.password = password
        if !username.isEmpty && Utils.isValidEmail(self.email) && Utils.isValidPassword(self.password) && isCheckedTermConditions {
            stateButton = .enabled
        } else {
            stateButton = .disabled
        }
    }
    
    func initRegister() {
        stateButton = .loading
        Task { [weak self] in
            guard let self else { return }
            let result = await useCase.registerUser(name: username, email: email, password: password)
            self.stateButton = .disabled
            switch result {
            case .success:
                self.displayRegisterSuccess = true
            case .failure(let error):
                self.displayRegisterSuccess = false
                self.displayErrorRegister = error
            }
        }
    }
}
