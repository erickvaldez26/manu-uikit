//
//  HomeDataSource.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import FirebaseFirestore
import FirebaseAuth

protocol HomeDataSourceProtocol: AnyObject {
    func getUserData() async throws -> UserInfoResponseDTO
    func getAllLoans() async throws -> [LoansResponseDTO]
    func getAllMonthlyPayments() async throws -> [MonthlyPaymentResponseDTO]
}

class HomeDataSource: HomeDataSourceProtocol {
    
    private let firestoreService: FirestoreServiceProtocol
    private let auth: Auth
    
    init(
        firestoreService: FirestoreServiceProtocol = FirestoreService(),
        auth: Auth = Auth.auth()
    ) {
        self.firestoreService = firestoreService
        self.auth = auth
    }
    
    private var uid: String {
        guard let uid = auth.currentUser?.uid else {
            fatalError("User not authenticated")
        }
        return uid
    }
    
    func getUserData() async throws -> UserInfoResponseDTO {
        let path = "users/\(uid)"
        return try await firestoreService.fetchDocument(path: path)
    }
    
    func getAllLoans() async throws -> [LoansResponseDTO] {
        let path = "users/\(uid)/loans"
        return try await firestoreService.fetchCollection(path: path)
    }
    
    func getAllMonthlyPayments() async throws -> [MonthlyPaymentResponseDTO] {
        let path = "users/\(uid)/debts"
        return try await firestoreService.fetchCollection(path: path)
    }

}
