//
//  TaxisFetchUseCaseTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisFetchUseCaseTests: XCTestCase {
    
    private var sut:  TaxisFetchUseCase!
    private var mockRepository: MockTaxisRepository!
    private let mockMapper = MockTaxisMapper()
    private let mockCoordinate = Coordinate(latitude: 12, longitude: 21)
    
    override func setUp() {
        super.setUp()
        mockRepository = MockTaxisRepository()
        sut = TaxisFetchUseCaseImpl(mapper: mockMapper, repository: mockRepository)
    }
    
    func testSuccess() {
        expectation { expectation in
            self.sut.onExecuted = { result in
                switch result {
                case .success((let vehicles, let viewDatas)):
                    XCTAssertEqual(vehicles.count, 2)
                    XCTAssertEqual(viewDatas.count, 1)
                    
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                }
                
            }
            self.sut.execute(start: self.mockCoordinate, destination: self.mockCoordinate)
        }
    }
    
    func testFailure() {
        mockRepository.success = false
        expectation { expectation in
            self.sut.onExecuted = { result in
                switch result {
                case .success((_, _)):
                    XCTFail()
                    
                case .failure(let error):
                    XCTAssertEqual(error as? Mocker.StubError, .fake)
                    expectation.fulfill()
                }
                
            }
            self.sut.execute(start: self.mockCoordinate, destination: self.mockCoordinate)
        }
    }
    
}
