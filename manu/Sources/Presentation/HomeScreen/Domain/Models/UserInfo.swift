//
//  UserInfo.swift
//  manu
//
//  Created by Erick Valdez on 6/05/25.
//

import Foundation
import FirebaseFirestore

struct UserInfo: Codable, Identifiable {
    @DocumentID var id: String?
    let email: String
    let name: String
    let totalBalance: Double
    
    init(id: String? = nil, email: String, name: String, totalBalance: Double) {
        self.id = id
        self.email = email
        self.name = name
        self.totalBalance = totalBalance
    }
}
