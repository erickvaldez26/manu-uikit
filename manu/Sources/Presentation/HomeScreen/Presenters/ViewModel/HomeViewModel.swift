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
    private let storage: StorageService
    
    @Published var displayUserInfo: UserInfo?
    @Published var displayMonthlyPayments: [MonthlyPayment]?
    @Published var displayErrorMonthlyPayments: MNRequestError?
    @Published var displayObfuscationBalance: Bool?
    
    private var isObfuscate: Bool = false
    
    init(useCase: HomeUseCasesProtocol, storage: StorageService) {
        self.useCase = useCase
        self.storage = storage
        loadUserInfo()
    }
    
    func loadUserInfo() {
        Task { [weak self] in
            guard let self else { return }
            let result = await useCase.getUserData()
            switch result {
            case .success(let data):
                displayUserInfo = data
                displayObfuscationBalance = (try? self.storage.get(AppStorageKey.obfuscationBalance, as: Bool.self)) ?? false
                fetchAllMonthlyPayment()
            case .failure:
                Utils.notifyShowGenericError()
            }
        }
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
    
    func calculateTotalMonthlyPayment() -> Double {
        var total: Double = .zero
        displayMonthlyPayments?.forEach {
            total += $0.amount
        }
        return total
    }
    
    func toggleObfuscationBalance() {
        displayObfuscationBalance?.toggle()
        try? storage.set(displayObfuscationBalance, for: AppStorageKey.obfuscationBalance)
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
