//
//  MapTaxisFetchUseCaseTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class MapTaxisFetchUseCaseTests: XCTestCase {
    
    private var sut:  MapTaxisFetchUseCase!
    private var mockRepository: MockTaxisRepository!
    private let mockMapper = MockMapTaxisMapper()
    private let mockCoordinate = Coordinate(latitude: 12, longitude: 21)

    override func setUp() {
        super.setUp()
        mockRepository = MockTaxisRepository()
        sut = MapTaxisFetchUseCaseImpl(mapper: mockMapper, repository: mockRepository)
    }

    func testSuccess() {
        expectation { expectation in
            self.sut.onExecuted = { result in
                switch result {
                case .success((let viewDatas)):
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
                case .success(_):
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

private struct MockMapTaxisMapper: MapTaxisMapper {
    
    func map(taxis: [Vehicle]) -> [TaxiAnnotationViewData] {
        [
            .init(coordinate: .init(latitude: 12.1212, longitude: 12.1232),
                  image: UIImage(named: "taxi-active")!)
        ]
    }
    
}
