//
//  TaxisFilterUseCaseTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisFilterUseCaseTests: XCTestCase {
    
    private var sut: TaxisFilterUseCase!
    private let mockMapper = MockTaxisMapper()
    
    override func setUp() {
        super.setUp()
        sut = TaxisFilterUseCaseImpl(mapper: mockMapper)
    }
    
    func testFilterActive() {
        let expected = makeVehicles()
        let result = sut.execute(list: expected, filter: .active)
    
        XCTAssertTrue(result.count > 0)
        XCTAssertEqual(mockMapper.taxis?.count, 1)
        XCTAssertEqual(mockMapper.taxis, [expected.first!])
    }
    
    func testFilterInactive() {
        let expected = makeVehicles()
        let result = sut.execute(list: expected, filter: .inactive)
    
        XCTAssertTrue(result.count > 0)
        XCTAssertEqual(mockMapper.taxis?.count, 1)
        XCTAssertEqual(mockMapper.taxis, [expected.last!])
    }
    
    func testFilterAll() {
        let expected = makeVehicles()
        let result = sut.execute(list: expected, filter: .all)
    
        XCTAssertTrue(result.count > 0)
        XCTAssertEqual(mockMapper.taxis?.count, 2)
        XCTAssertEqual(mockMapper.taxis, expected)
    }
    
    func testEmpty() {
        let _ = sut.execute(list: [], filter: .all)
    
        XCTAssertEqual(mockMapper.taxis?.count, 0)
    }
    
}

private extension TaxisFilterUseCaseTests {
    
    
    func makeVehicles() -> [Vehicle] {
        [
            .init(id: 1,
                  state: .active,
                  type: .taxi,
                  heading:  0.12,
                  coordinate: .init(latitude: 1.1, longitude: 1.2)),
            .init(id: 2,
                  state: .inactive,
                  type: .taxi,
                  heading:  0.12,
                  coordinate: .init(latitude: 1.1, longitude: 1.2))
        ]
    }
}
