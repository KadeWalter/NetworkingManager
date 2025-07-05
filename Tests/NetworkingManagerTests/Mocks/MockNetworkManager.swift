//
//  MockNetworkManager.swift
//  Stocks
//
//  Created by Kade Walter on 7/2/25.
//

@testable import NetworkingManager
import Foundation

class MockNetworkManager: NetworkManaging {
    
    var stubError: APIErrors?
    var stubData: Data?
    
    func fetch<T: Decodable>(as type: T.Type, endpoint: URL?) async throws -> T {
        if let stubError { throw stubError }
        
        return try JSONDecoder().decode(T.self, from: stubData!)
    }
}
