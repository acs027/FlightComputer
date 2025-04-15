//
//  NetworkMonitor.swift
//  FlightComputer
//
//  Created by ali cihan on 11.04.2025.
//

import Observation
import Network

@Observable
final class NetworkMonitor {
    var hasNetworkConnection = false
    
    private let networkMonitor = NWPathMonitor()
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.hasNetworkConnection = path.status == .satisfied
        }
        networkMonitor.start(queue: DispatchQueue.global())
    }
}
