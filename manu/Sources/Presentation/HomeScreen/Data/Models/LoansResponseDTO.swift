//
//  LoansResponseDTO.swift
//  manu
//
//  Created by Erick Valdez on 7/05/25.
//

import Foundation
import FirebaseFirestore

struct LoansResponseDTO: Codable, Identifiable {
    @DocumentID var id: String?
    let amount: Double
    let date: Date
    let havePlin: Bool
    let haveYape: Bool
    let personName: String
    let type: Int
    
    init(
        id: String? = nil,
        amount: Double,
        date: Date,
        havePlin: Bool,
        haveYape: Bool,
        personName: String,
        type: Int
    ) {
        self.id = id
        self.amount = amount
        self.date = date
        self.havePlin = havePlin
        self.haveYape = haveYape
        self.personName = personName
        self.type = type
    }
}
