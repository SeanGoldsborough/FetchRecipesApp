//
//  NetworkManager.swift
//  FetchRecipesAppTests
//
//  Created by Sean Goldsborough on 4/17/25.
//

import XCTest
@testable import FetchRecipesApp

final class NetworkManager_Tests: XCTestCase {
    
    private var networkManager: NetworkManager!
    private var expectation: XCTestExpectation!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        networkManager = NetworkManager()
        expectation = expectation(description: "Expectation")
    }
    
    func getEmptyRecipesSuccessfulResponse() async {
        let jsonString = networkManager.readJSONFile(forName: "recipiesEmpty")
        let data = jsonString.data(using: .utf8)

        MockURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        do {
            let recipes = try await networkManager.getData(with: NetworkManager.Constants.URL.APIEmptyPath)
            XCTAssertTrue(recipes.isEmpty)
            self.expectation.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func getRecipesSuccessfulResponse() async {
        let jsonString = networkManager.readJSONFile(forName: "recipies")
        let data = jsonString.data(using: .utf8)

        MockURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        do {
            let recipes = try await networkManager.getData(with: NetworkManager.Constants.URL.APIHappyPath)
            XCTAssertTrue(!recipes.isEmpty)
            
            let newJSONString = networkManager.json(from: recipes)
            XCTAssertEqual(jsonString, newJSONString)
            
            self.expectation.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
