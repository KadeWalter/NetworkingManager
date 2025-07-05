//
//  NetworkManagerTests.swift
//  StocksTests
//
//  Created by Kade Walter on 7/2/25.
//

@testable import NetworkingManager
import XCTest

final class NetworkManagerTests: XCTestCase {
    
    private var networkManager: NetworkManager!
    private var mockURLSession: MockURLSession!
    private var exampleStockData: ExampleDecodableData!
    
    private let goodURLResponse = HTTPURLResponse(url: URL(string: "https://www.someurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    private let badURLResponse = HTTPURLResponse(url: URL(string: "https://www.someurl.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkManager = NetworkManager(urlSession: mockURLSession)
        exampleStockData = ExampleDecodableData()
    }
    
    override func tearDown() {
        networkManager = nil
        exampleStockData = nil
        super.tearDown()
    }
    
    func test_decodeStockInformation_normalData() async {
        mockURLSession.stubData = exampleStockData.normalData
        mockURLSession.stubResonse = goodURLResponse
        
        let data = try! await networkManager.fetch(as: DecodableData.self, endpoint: URL(string: "https://www.someurl.com"))
        
        XCTAssertFalse(data.data.isEmpty)
        XCTAssertEqual(data.data.count, 3)
    }
    
    func test_decodeStockInformation_emptyData() async {
        mockURLSession.stubData = exampleStockData.emptyData
        mockURLSession.stubResonse = goodURLResponse
        
        let data = try! await networkManager.fetch(as: DecodableData.self, endpoint: URL(string: "https://www.someurl.com"))
        
        XCTAssertTrue(data.data.isEmpty)
        XCTAssertEqual(data.data.count, 0)
    }
    
    func test_decodeStockInformation_malformedData_One() async {
        mockURLSession.stubData = exampleStockData.malformedData
        mockURLSession.stubResonse = goodURLResponse
        
        var data: DecodableData?
        
        do {
            data = try await networkManager.fetch(as: DecodableData.self, endpoint: URL(string: "https://www.someurl.com"))
            XCTFail( "Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? APIErrors, APIErrors.decodingFailed)
            XCTAssertNil(data)
        }
    }
    
    func test_fetch_fails_with_invalid_url() async {
        let url = URL(string: "")
        
        do {
            _ = try await networkManager.fetch(as: DecodableData.self, endpoint: url)
            XCTFail( "Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? APIErrors, APIErrors.invalidUrl)
        }
    }
    
    func test_fetch_fails_with_nil_url() async {
        do {
            _ = try await networkManager.fetch(as: DecodableData.self, endpoint: nil)
            XCTFail( "Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? APIErrors, APIErrors.invalidUrl)
        }
    }
    
    func test_validResponse_throwsError() async {
        mockURLSession.stubData = exampleStockData.emptyData
        mockURLSession.stubResonse = badURLResponse
        
        do {
            let _ = try await networkManager.fetch(as: DecodableData.self, endpoint: URL(string: "https://www.someurl.com"))
            XCTFail( "Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? APIErrors, APIErrors.invalidResponse)
        }
    }
    
    func test_validResponse_success() async {
        mockURLSession.stubData = exampleStockData.emptyData
        mockURLSession.stubResonse = goodURLResponse
        
        do {
            let _ = try await networkManager.fetch(as: DecodableData.self, endpoint: URL(string: "https://www.someurl.com"))
        } catch {
            XCTFail( "Expected not to throw an error")
        }
        
    }
}
