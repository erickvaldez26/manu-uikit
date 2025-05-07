//
//  HomeDataSource.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import FirebaseFirestore
import FirebaseAuth

protocol HomeDataSourceProtocol: AnyObject {
    func getUserData() async -> Result<UserInfoResponseDTO, Error>
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], Error>
}

class HomeDataSource: HomeDataSourceProtocol {
    let uid = Auth.auth().currentUser?.uid ?? ""
    
    func getUserData() async -> Result<UserInfoResponseDTO, Error> {
        do {
            let db = Firestore.firestore()
            let result = try await db.collection("users").document(uid).getDocument()
            if let userInfo = try? result.data(as: UserInfoResponseDTO.self) {
                return .success(userInfo)
            } else {
                return .failure(NSError(domain: "", code: -1))
            }
        } catch(let error) {
            return .failure(error)
        }
    }
    
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], Error> {
        do {
            let db = Firestore.firestore()
            let result = try await db.collection("users").document(uid).collection("debts").getDocuments()
            let debts: [MonthlyPaymentResponseDTO] = result.documents.compactMap { document in
                try? document.data(as: MonthlyPaymentResponseDTO.self)
            }
            return .success(debts)
        } catch(let error) {
            return .failure(error)
        }
    }

}
