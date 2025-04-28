//
//  MNRequestError.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import Foundation

struct MNRequestError: Error {
    let code: String
    let description: String
    
    init(from error: Error) {
        if let nsError = error as? NSError {
            self.code = "Code-\(nsError.code)"
            self.description = nsError.localizedDescription
        } else {
            self.code = "UNKNOWN_ERROR"
                        self.description = error.localizedDescription
        }
    }
}
