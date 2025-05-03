//
//  MonthlyPayment.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import Foundation
import FirebaseFirestore

struct MonthlyPayment: Codable, Identifiable {
    @DocumentID var id: String?
    var amount: Double
    var endDate: Date
    var imageRef: String
    var nameService: String
    var paymentDate: String
    var quotas: Int
    var startDate: Date
    var typeService: String
    
    init(
        id: String? = nil,
        amount: Double,
        endDate: Date,
        imageRef: String,
        nameService: String,
        paymentDate: String,
        quotas: Int,
        startDate: Date,
        typeService: String
    ) {
        self.id = id
        self.amount = amount
        self.endDate = endDate
        self.imageRef = imageRef
        self.nameService = nameService
        self.paymentDate = paymentDate
        self.quotas = quotas
        self.startDate = startDate
        self.typeService = typeService
    }
}
