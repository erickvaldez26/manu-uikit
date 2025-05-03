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
    var amount: Double
    var endDate: Date
    var imageRef: String
    var nameService: String
    var paymentDate: String
    var quotas: Int
    var startDate: Date
    var typeService: String
}
