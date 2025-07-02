//
//  ExampleDecodableData.swift
//  Stocks
//
//  Created by Kade Walter on 7/2/25.
//

import Foundation

// Example stocks objects converted to data for testing
struct ExampleDecodableData { }

// MARK: Normal Data
extension ExampleDecodableData {
    var normalData: Data {
        return """
            {
                "data": [
                    {
                        "name": "Test 1",
                        "value": 123
                    },
                    {
                        "name": "Test 2",
                        "value": 456
                    },            
                    {
                        "name": "Test 3",
                        "value": 789
                    }
                ]
            }
        """.data(using: .utf8)!
    }
}

// MARK: Empty Data
extension ExampleDecodableData {
    var emptyData: Data {
        return """
            {
                "data": []
            }
        """.data(using: .utf8)!
    }
}

// MARK: Malformed Data
extension ExampleDecodableData {
    // Tagged with malformed at the end of json data
    var malformedData: Data {
        return """
            {
                "data": [
                        "name": "Test 1",
                        "value": 123,
                    },
                    {
                        "name": "Test 2",
                        "value": 456,
                    },
                    {
                        "name": "Test 3",
                        "value": 789,
                    }
                ]
            }malformed
        """.data(using: .utf8)!
    }
}
