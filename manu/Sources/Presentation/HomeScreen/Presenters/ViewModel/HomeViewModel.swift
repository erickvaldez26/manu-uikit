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
    @Published var displayLoans: [Loans]?
    @Published var displayMonthlyPayments: [MonthlyPayment]?
    @Published var displayErrorMonthlyPayments: MNRequestError?
    @Published var displayObfuscationBalance: Bool?
    
    private var isObfuscate: Bool = false
    
    init(useCase: HomeUseCasesProtocol, storage: StorageService) {
        self.useCase = useCase
        self.storage = storage
        
        Task { await loadUserInfo() }
    }
    
    func loadUserInfo() async {
        do {
            displayUserInfo = try await useCase.getUserData()
            displayObfuscationBalance = (try? self.storage.get(AppStorageKey.obfuscationBalance, as: Bool.self)) ?? false
            await fetchAllLoans()
        } catch {
            GlobalErrorHandler.shared.sendError(.noInternet)
        }
    }
    
    func fetchAllLoans() async {
        do {
            displayLoans = try await useCase.getAllLoans()
            await fetchAllMonthlyPayment()
        } catch {
//            Utils.notifyShowGenericError()
        }
    }
    
    func fetchAllMonthlyPayment() async {
        do {
            displayMonthlyPayments = try await useCase.getAllMonthlyPayment()
            Utils.notifyHideLoader()
        } catch {
            displayErrorMonthlyPayments = error as! MNRequestError
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
