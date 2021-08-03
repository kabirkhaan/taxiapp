//
//  TaxisViewModelTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisViewModelTests: XCTestCase {
    
    private var sut: TaxisViewModel!
    private var mockFetchUseCase: MockTaxisFetchUseCase!
    private var mockTaxisFilterUseCase: MockTaxisFilterUseCase!
    
    override func setUp() {
        super.setUp()
        
        mockFetchUseCase = MockTaxisFetchUseCase()
        
        mockFetchUseCase.mockResult = .success((makeVehicles(), makeTaxiViewDatas()))
        mockTaxisFilterUseCase = MockTaxisFilterUseCase()
        sut = TaxisViewModelImpl(fetchTaxisUseCase: mockFetchUseCase,
                                 filterTaxisUseCase: mockTaxisFilterUseCase)
    }
    
    
    func testRefresh_Success() {
        var loadingCount = 0
        var changeFilterCount = 0
        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .changeFilter(let index):
                    XCTAssertEqual(index, 0)
                    changeFilterCount += 1
                case .loading:
                    loadingCount += 1
                case .updated:
                    XCTAssertEqual(self.sut.count(), 1)
                    let indexPath = IndexPath(row: 0, section: 0)
                    
                    XCTAssertNotNil(self.sut.object(at: indexPath))
                    
                    XCTAssertEqual(loadingCount, 1)
                    XCTAssertEqual(changeFilterCount, 1)
                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.refresh()
        }
    }
    
    func testRefresh_Failure() {
        mockFetchUseCase.mockResult = .failure(Mocker.StubError.fake)
        
        var loadingCount = 0
        var changeFilterCount = 0
        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .changeFilter(let index):
                    XCTAssertEqual(index, 0)
                    changeFilterCount += 1
                case .loading:
                    loadingCount += 1
                case .error(let message):
                    XCTAssertNotNil(message)
                    
                    XCTAssertEqual(loadingCount, 1)
                    XCTAssertEqual(changeFilterCount, 1)
                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.refresh()
        }
    }
    
    func testFiltersViewData() {
        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .updated:
                    XCTAssertEqual(self.sut.count(), 1)
                                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.apply(filter: 0)
        }
    
    }
    
    func testApplyFilter() {
        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .updated:
                    XCTAssertEqual(self.sut.count(), 1)
                                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.apply(filter: 0)
        }
    }
    
    func testApplyFilter_OutOfBound() {
        expectation { expectation in
            self.sut.onStateChange = { state in
                switch state {
                case .updated:
                    XCTAssertEqual(self.sut.count(), 1)
                                    
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
            
            self.sut.apply(filter: 34)
        }
    }
    
    func testCount_EmptyList() {
       XCTAssertEqual(sut.count(), 0) 
    }
    
    func testObjectAtIndex_EmptyList() {
        let indexPath = IndexPath(row: 0, section: 0)
        
        XCTAssertNil(sut.object(at: indexPath))
    }
    
    func testObjectAtIndex_OutOfBound() {
        let indexPath = IndexPath(row: 21, section: 12)
        
        XCTAssertNil(sut.object(at: indexPath))
    }
    
    
}

private extension TaxisViewModelTests {
    
    func makeTaxiViewDatas() -> [TaxiViewData] {
        [
            .init(image: UIImage(named: "taxi-active")!, text: "Active")
        ]
    }
    
    func makeVehicles() -> [Vehicle] {
        [
            .init(id: -723528,
                  state: .active,
                  type: .taxi,
                  heading:  281.30,
                  coordinate: .init(latitude: 53.63, longitude: 10.00))
        ]
    }
}

private class MockTaxisFetchUseCase: TaxisFetchUseCase {
    
    var onExecuted: Response?
    var mockResult: Result<([Vehicle], [TaxiViewData]), Error>?
    
    func execute(start: Coordinate, destination: Coordinate) {
        onExecuted?(mockResult!)
    }
    
    
}

private class MockTaxisFilterUseCase: TaxisFilterUseCase {
    
    func execute(list: [Vehicle], filter: TaxiViewFilter) -> [TaxiViewData] {
        return [
            .init(image: UIImage(named: "taxi-active")!, text: "Active")
        ]
    }
    
}
