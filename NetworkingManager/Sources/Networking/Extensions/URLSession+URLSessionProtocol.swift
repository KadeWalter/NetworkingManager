//
//  URLSession+URLSessionProtocol.swift
//  Stocks
//
//  Created by Kade Walter on 7/2/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession : URLSessionProtocol { }
