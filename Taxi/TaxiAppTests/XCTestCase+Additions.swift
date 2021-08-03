//
//  XCTestCase+Additions.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation

import XCTest

extension XCTestCase {
    
    func expectation(timeout: TimeInterval = 1.0,
                     handler: @escaping (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: "com.taxi.app.async.expectation")
        handler(expectation)
        wait(for: [expectation], timeout: timeout)
    }
    
}
