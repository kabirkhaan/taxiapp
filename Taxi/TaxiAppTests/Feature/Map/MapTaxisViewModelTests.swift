//
//  MapTaxisViewModelTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class MapTaxisViewModelTests: XCTestCase {

    private var sut: MapTaxisViewModel!
    private var mockFetchUseCase: MockMapTaxisFetchUseCase!
    
    override func setUp() {
        super.setUp()
        
        mockFetchUseCase = MockMapTaxisFetchUseCase()
        
        sut = MapTaxisViewModelImpl(useCase: mockFetchUseCase)
    }
    
    func testRefreshSuccess() {
        mockFetchUseCase.mockResult = .success([
            .init(coordinate: .init(latitude: 2, longitude: 2),
                  image: UIImage())
        ])
        
        var loadingCount = 0

        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .loading:
                    loadingCount += 1
                case .updated(let list):
                    XCTAssertEqual(list.count, 1)
                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.refresh()
        }
    }
    
    func testRefreshError() {
        mockFetchUseCase.mockResult = .failure(Mocker.StubError.fake)
        
        var loadingCount = 0

        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .loading:
                    loadingCount += 1
                case .error(let message):
                    XCTAssertNotNil(message)
                    XCTAssertEqual(loadingCount, 1)
                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.refresh()
        }
    }
}

private class MockMapTaxisFetchUseCase: MapTaxisFetchUseCase {
    
    var onExecuted: Response?
    var mockResult: Result<([TaxiAnnotationViewData]), Error>?
    
    func execute(start: Coordinate, destination: Coordinate) {
        onExecuted?(mockResult!)
    }
    
    
}
