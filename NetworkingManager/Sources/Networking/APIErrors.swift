//
//  StockAPIErrors.swift
//  Stocks
//
//  Created by Kade Walter on 7/2/25.
//

// Possible errors when fetching data using the NetworkManager
enum APIErrors: Error {
    case invalidUrl
    case invalidResponse
    case decodingFailed
    case emptyData
    case unknown
    
    var errorMessage: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid HTTP response"
        case .decodingFailed:
            return "Decoding failed"
        case .emptyData:
            return "Empty data returned"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
