//
//  MapTaxisFactoryTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class MapTaxisFactoryTests: XCTestCase {

    private var sut: MapTaxisFactory!
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock<Mocker.EmptyResponse>()
        sut = MapTaxisFactory(networkService: networkService)
    }
    
    
    func testCoordinator() {
       XCTAssertTrue(sut.makeCoordinator(navigationController: UINavigationController()) is MapTaxisCoordinator)
    }
    
    func testMakeViewController() {
       XCTAssertTrue(sut.makeViewController() is MapTaxisViewController) 
    }
    
}
