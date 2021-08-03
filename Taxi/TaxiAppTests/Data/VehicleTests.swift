//
//  VehicleTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class VehicleTests: XCTestCase {
    
    private var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        decoder  = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
    }
    
    func testState_Active_UpperCase() {
        let sut = try? decoder.decode(Vehicle.self, from: makeResponse(for: "ACTIVE", type: "TAXI"))
        let expected = makeVehicle(for: .active, type: .taxi)
        
        XCTAssertEqual(sut, expected)
    }
    
    func testState_Inactive_UpperCase() {
        let sut = try? decoder.decode(Vehicle.self, from: makeResponse(for: "INACTIVE", type: "TAXI"))
        let expected = makeVehicle(for: .inactive, type: .taxi)
        
        XCTAssertEqual(sut, expected)
    }
    
    func testType_Taxi_UpperCase() {
        let sut = try? decoder.decode(Vehicle.self, from: makeResponse(for: "ACTIVE", type: "TAXI"))
        let expected = makeVehicle(for: .active, type: .taxi)
        
        XCTAssertEqual(sut, expected)
    }
    
    func test_State_LowerCase() {
        XCTAssertThrowsError(try decoder.decode(Vehicle.self, from: makeResponse(for: "active", type: "TAXI"))) { error in
            XCTAssertNotNil(error)
        }
    }
    
    func test_Type_LowerCase() {
        XCTAssertThrowsError(try decoder.decode(Vehicle.self, from: makeResponse(for: "INACTIVE", type: "taxi"))) { error in
            XCTAssertNotNil(error)
        }
    }
    
}

private extension VehicleTests {
    
    func makeVehicle(for state: Vehicle.State, type: Vehicle.`Type`) -> Vehicle {
        .init(id: 123,
              state: state,
              type: type,
              heading:  0.12,
              coordinate: .init(latitude: 1.1, longitude: 1.2))
    }
    
    func makeResponse(for state: String, type: String) -> Data {
        Data(
            """
                {
                    "id": 123,
                    "state": "\(state)",
                    "type": "\(type)",
                    "heading": 0.12,
                    "coordinate": {
                        "latitude": 1.1,
                        "longitude": 1.2
                    }
                }
        """.utf8)
    }
    
}
