//
//  RegisterModel.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import Foundation

struct RegisterModel: Codable {
    let uid: String
    let displayName: String?
    let username: String?
    let isNewUser: Bool
    let accessToken: String?
    
    init(
        uid: String,
        displayName: String?,
        username: String?,
        isNewUser: Bool,
        accessToken: String?
    ) {
        self.uid = uid
        self.displayName = displayName
        self.username = username
        self.isNewUser = isNewUser
        self.accessToken = accessToken
    }
}
