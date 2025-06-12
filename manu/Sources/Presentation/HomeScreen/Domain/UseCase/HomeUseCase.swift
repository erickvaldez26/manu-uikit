//
//  HomeUseCase.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import FirebaseFirestore

protocol HomeUseCasesProtocol: AnyObject {
    func getUserData() async throws -> UserInfo
    func getAllLoans() async throws -> [Loans]
    func getAllMonthlyPayment() async throws -> [MonthlyPayment]
}

class HomeUseCases: HomeUseCasesProtocol {
    
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUserData() async throws -> UserInfo {
        try await repository.getUserData()
    }
    
    func getAllLoans() async throws -> [Loans] {
        try await repository.getAllLoans()
    }
    
    func getAllMonthlyPayment() async throws -> [MonthlyPayment] {
        try await repository.getAllMonthlyPayment()
    }
    
}
