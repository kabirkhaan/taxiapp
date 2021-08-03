//
//  RootVehiclesTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 20.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class RootVehiclesTests: XCTestCase {
    
    private var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        decoder  = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
    }
    
    func testRoot() {
        XCTAssertNoThrow(try decoder.decode(RootVehicles.self, from: makeResponse()))
    }
    
    func testVehicles() {
        let sut = try? decoder.decode(RootVehicles.self, from: makeResponse())
        let expected = makeVehicles()
        
        XCTAssertEqual(sut?.vehicles, expected)
    }
    
}

private extension RootVehiclesTests {
    
    func makeVehicles() -> [Vehicle] {
        [
            .init(id: -723528,
                  state: .active,
                  type: .taxi,
                  heading:  281.30,
                  coordinate: .init(latitude: 53.63, longitude: 10.00)),
            .init(id: 1884800943,
                  state: .inactive,
                  type: .taxi,
                  heading:  149.06,
                  coordinate: .init(latitude: 53.54, longitude: 10.10))
        ]
    }
    
    func makeResponse() -> Data {
        Data(
            """
                 {
                     "poiList": [{
                             "id": -723528,
                             "coordinate": {
                                 "latitude": 53.63,
                                 "longitude": 10.00
                             },
                             "state": "ACTIVE",
                             "type": "TAXI",
                             "heading": 281.30
                         },
                         {
                             "id": 1884800943,
                             "coordinate": {
                                 "latitude": 53.54,
                                 "longitude": 10.10
                             },
                             "state": "INACTIVE",
                             "type": "TAXI",
                             "heading": 149.06
                         }
                     ]
                 }
        """.utf8)
    }
    
}
