//
//  AuthLoginViewModel.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Combine

class AuthLoginViewModel: ObservableObject {
    private let useCase: LoginUseCasesImpl
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var stateButton: MNButton.State = .disabled
    @Published var displayLoginSuccess: Bool = false
    @Published var displayErrorLogin: MNRequestError?
    
    init(useCase: LoginUseCasesImpl) {
        self.useCase = useCase
    }
    
    func validateFields(email: String, password: String) {
        self.email = email
        self.password = password
        if Utils.isValidEmail(email) && !password.isEmpty {
            stateButton = .enabled
        } else {
            stateButton = .disabled
        }
    }
    
    func initLogin() {
        stateButton = .loading
        Task { [weak self] in
            guard let self else { return }
            do {
                try await useCase.signInWithEmail(email: email, password: password)
                self.displayLoginSuccess = true
            } catch {
                self.displayLoginSuccess = false
//                self.displayErrorLogin = error
            }
            self.stateButton = .disabled
        }
    }
}
