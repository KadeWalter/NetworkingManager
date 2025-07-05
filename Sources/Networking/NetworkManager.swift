//
//  NetworkManager.swift
//  Stocks
//
//  Created by Kade Walter on 7/2/25.
//

import Foundation

protocol NetworkManaging {
    func fetch<T: Decodable>(as type: T.Type, endpoint: URL?) async throws -> T
}

class NetworkManager: NetworkManaging {
    
    private var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    
    func fetch<T: Decodable>(as type: T.Type, endpoint: URL?) async throws -> T {
        guard let endpoint else {
            throw APIErrors.invalidUrl
        }
        
        let (data, response) = try await urlSession.data(from: endpoint, delegate: nil)
        
        try validateResponse(response: response)
    
        return try decodeData(as: type, data: data)
    }
    
    private func validateResponse(response: URLResponse) throws {
        guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            throw APIErrors.invalidResponse
        }
    }
    
    private func decodeData<T: Decodable>(as type: T.Type, data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw APIErrors.decodingFailed
        }
    }
}
