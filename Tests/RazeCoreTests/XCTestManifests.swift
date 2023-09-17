//
//  XCTestManifests.swift
//  
//
//  Created by Tim Mitra on 9/17/23.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RazeColorTests.allTests),
        testCasse(RazeNetworkingTests.allTests)
    ]
}
#endif
