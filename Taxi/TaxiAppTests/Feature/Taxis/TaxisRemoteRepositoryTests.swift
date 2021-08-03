//
//  TaxisRemoteRepositoryTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisRemoteRepositoryTests: XCTestCase {
    
    private var service = NetworkServiceMock<RootVehicles>()
    private var sut: TaxisRemoteRepository!
    
    override func setUp() {
        super.setUp()
        sut = TaxisRemoteRepositoryImpl(service: service)
    }
    
    func testSuccess() {
        service.mockResult = .success(RootVehicles(vehicles: []))
        
        let mockCoordinate = Coordinate(latitude: 1, longitude: 1)
        let expected = RootVehicles(vehicles: [])
        var result: Result<RootVehicles, Error>?
        
        sut.getAll(start: mockCoordinate, destination: mockCoordinate) { result = $0 }
        
        XCTAssertNoThrow(try result?.get())
        XCTAssertEqual(try result?.get(), expected)
        XCTAssertEqual(service.requestCallCount, 1)
    }
    
    func testFailure() {
        service.mockResult = .failure(Mocker.StubError.fake)
        
        let mockCoordinate = Coordinate(latitude: 1, longitude: 1)
        var result: Result<RootVehicles, Error>?
        
        sut.getAll(start: mockCoordinate, destination: mockCoordinate) { result = $0 }
        
        XCTAssertThrowsError(try result?.get())
        XCTAssertEqual(service.requestCallCount, 1)
    }
    
}
