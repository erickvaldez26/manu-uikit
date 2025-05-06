//
//  HomeViewModel.swift
//  manu
//
//  Created by Erick Valdez on 3/05/25.
//

import Combine
import FirebaseAuth

class HomeViewModel: ObservableObject {
    private let useCase: HomeUseCasesProtocol
    
    @Published var displayMonthlyPayments: [MonthlyPayment]?
    @Published var displayErrorMonthlyPayments: MNRequestError?
    
    init(useCase: HomeUseCasesProtocol) {
        self.useCase = useCase
    }
    
    func fetchAllMonthlyPayment() {
        Task { [weak self] in
            guard let self else { return }
            let result = await useCase.getAllMonthlyPayment()
            Utils.notifyHideLoader()
            switch result {
            case .success(let data):
                displayMonthlyPayments = data
            case .failure(let error):
                displayErrorMonthlyPayments = error
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("APP -> Sesión cerrada")
        } catch {
            print("APP -> Fallo al cerrar sesión")
        }
    }
}
