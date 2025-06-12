//
//  ConnectivityChecking.swift
//  manu
//
//  Created by Erick Valdez on 4/10/25.
//

protocol ConnectivityChecking {
    func withConnectivity<T>(
        _ block: @escaping () async throws -> T
    ) async throws -> T
}

extension ConnectivityChecking {
    func withConnectivity<T>(
        _ block: @escaping () async throws -> T
    ) async throws -> T {
        if !NetworkMonitor.shared.isConnected() {
            GlobalErrorHandler.shared.sendError(.noInternet)
            
            throw AppError.noInternet
        }
        
        do {
            let result = try await block()
            return result
        } catch {
            throw AppError.generic(message: "")
        }
    }
}
