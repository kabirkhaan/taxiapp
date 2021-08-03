//
//  TaxisFactoryTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisFactoryTests: XCTestCase {

    private var sut: TaxisFactory!
    
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock<Mocker.EmptyResponse>()
        sut = TaxisFactory(networkService: networkService)
    }
    
    func testCoordinator() {
       XCTAssertTrue(sut.makeCoordinator(navigationController: UINavigationController()) is TaxisCoordinator)
    }
    
    func testMakeViewController() {
       XCTAssertTrue(sut.makeViewController() is TaxisViewController)
    }
    
}
