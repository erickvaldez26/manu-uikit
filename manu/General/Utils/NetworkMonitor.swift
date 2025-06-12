//
//  NetworkMonitor.swift
//  manu
//
//  Created by Erick Valdez on 4/10/25.
//

import Foundation
import Network

enum ConnectivityState {
    case satisfied
    case unsatisfied
    case requiresConnection
}

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private(set) var currentState: ConnectivityState = .unsatisfied
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.currentState = .satisfied
            } else if path.status == .unsatisfied {
                self?.currentState = .unsatisfied
            } else {
                self?.currentState = .requiresConnection
            }
        }
        monitor.start(queue: queue)
    }
    
    func isConnected() -> Bool {
        return currentState == .satisfied
    }
}
