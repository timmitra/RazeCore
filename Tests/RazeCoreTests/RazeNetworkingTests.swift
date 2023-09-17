//
//  RazeNetworkingTests.swift
//  
//
//  Created by Tim Mitra on 9/17/23.
//

import XCTest
@testable import RazeCore

final class RazeNetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let expectation = XCTestExpectation(description: "CalledForData")
        guard let url = URL(string: "https://raywenderlich.com") else {
            return XCTFail("Could not create the URL properly")
        }
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertNotNil(returnedData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for: [expectation])
    }
    
    static var allTests = [
        ("testLoadDataCall", testLoadDataCall)
    ]
}
