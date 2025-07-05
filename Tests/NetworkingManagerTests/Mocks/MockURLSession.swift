//
//  MockURLSession.swift
//  Stocks
//
//  Created by Kade Walter on 6/15/25.
//

@testable import NetworkingManager
import Foundation

class MockURLSession: URLSessionProtocol {
    
    var stubResonse: URLResponse?
    var stubData: Data?
    
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return (stubData!, stubResonse!)
    }
}
