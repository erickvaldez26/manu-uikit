//
//  HomeRepositoryProtocol.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import FirebaseFirestore

protocol HomeRepositoryProtocol: AnyObject {
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], Error>
}
