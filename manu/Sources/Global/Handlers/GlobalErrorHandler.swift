//
//  GlobalErrorHandler.swift
//  manu
//
//  Created by Erick Valdez on 4/10/25.
//

import Foundation

class GlobalErrorHandler {
    static let shared = GlobalErrorHandler()
    
    var onError: ((AppError) -> Void)?
    
    private init() {}
    
    func sendError(_ error: AppError) {
        DispatchQueue.main.async {
            self.onError?(error)
        }
    }
}
