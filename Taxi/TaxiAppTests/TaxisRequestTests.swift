//
//  TaxisRequestTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisRequestTests: XCTestCase {
    
    private var sut: TaxisRequest!
    
    override func setUp() {
        super.setUp()
        sut = makeTaxisRequest()
    }
    
    func testHttpMethod() {
        let expected = RequestHTTPMethod.get
        
        XCTAssertEqual(sut.method, expected)
    }
    
    func testUrl() {
        let expected = URL(string: "https://poi-api.mytaxi.com/PoiService/poi/v1")
        
        XCTAssertEqual(sut.url, expected)
    }
    
    func testParameter() {
        let expected = [
            "p1Lat": "53.694865",
            "p1Lon": "9.757589",
            "p2Lat": "53.394655",
            "p2Lon": "10.099891"
        ]
        
        XCTAssertEqual(sut.parameters["p1Lat"], expected["p1Lat"])
        XCTAssertEqual(sut.parameters["p1Lon"], expected["p1Lon"])
        XCTAssertEqual(sut.parameters["p2Lat"], expected["p2Lat"])
        XCTAssertEqual(sut.parameters["p2Lon"], expected["p2Lon"])
    }
    
    func testRequestUrl() {
        let sut = makeTaxisRequest()
        let url = try? sut.asURLRequest().asURLRequest().url
        let expected = URL(string: "https://poi-api.mytaxi.com/PoiService/poi/v1?p1Lat=53.694865&p1Lon=9.757589&p2Lat=53.394655&p2Lon=10.099891")
        
        XCTAssertEqual(url, expected)
    }
    
}

private extension TaxisRequestTests {
    
    func makeTaxisRequest() -> TaxisRequest {
        return .init(start: .init(latitude: 53.694865, longitude: 9.757589),
                     destination: .init(latitude: 53.394655, longitude: 10.099891))
    }
    
}
