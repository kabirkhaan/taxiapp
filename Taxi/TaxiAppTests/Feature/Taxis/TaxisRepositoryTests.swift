//
//  TaxisRepositoryTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisRepositoryTests: XCTestCase {

    private var sut: TaxisRepository!
    private let repository = MockTaxisRemoteRepository()
    private let mockCoordinate = Coordinate(latitude: 1, longitude: 1)
    
    override func setUp() {
        super.setUp()
        sut = TaxisRepositoryImpl(remoteRepository: repository)
    }
    
    func testSuccess() {
        expectation { expectation in
            self.sut.getAll(start: self.mockCoordinate, destination: self.mockCoordinate) { result in
                switch result {
                case .success(let root):
                    let expected = [Vehicle]()

                    XCTAssertEqual(root, expected)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                }
            }
        }
    }
    
    func testFailure() {
        repository.success = false
        
        expectation { expectation in
            self.sut.getAll(start: self.mockCoordinate, destination: self.mockCoordinate) { result in
                switch result {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(error as! Mocker.StubError, Mocker.StubError.fake)
                    expectation.fulfill()
                }
            }
        }
        
    }
    
}

private final class MockTaxisRemoteRepository: TaxisRemoteRepository {
    
    var success = true
    
    func getAll(start: Coordinate,
             destination: Coordinate,
             completion: @escaping (Result<RootVehicles, Error>) -> Void) {
        guard success else {
            completion(.failure(Mocker.StubError.fake))
            return
        }
        
        completion(.success( RootVehicles(vehicles: [])))
    }
    
}
