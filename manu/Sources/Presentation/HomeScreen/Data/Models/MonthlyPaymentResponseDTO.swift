//
//  MonthlyPaymentResponseDTO.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import Foundation
import FirebaseFirestore

struct MonthlyPaymentResponseDTO: Codable, Identifiable {
    @DocumentID var id: String?
    let amount: Double
    let endDate: Date
    let imageRef: String
    let nameService: String
    let paymentDate: String
    let quotas: Int
    let startDate: Date
    let typeService: String
    
    func toDomain() -> MonthlyPayment {
        return MonthlyPayment(
            amount: self.amount,
            endDate: self.endDate,
            imageRef: self.imageRef,
            nameService: self.nameService,
            paymentDate: self.paymentDate,
            quotas: self.quotas,
            startDate: self.startDate,
            typeService: self.typeService
        )
    }
}
