//
//  TaxisMapperTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class TaxisMapperTests: XCTestCase {
    
    private var sut: TaxisMapper!
    
    override func setUp() {
        super.setUp()
        sut = TaxisMapperImpl()
    }
    
    func testMap_ActiveState() {
        let expected = [
            makeTaxiViewData(imageName: Constant.ImageName.active)
        ]
        let list = [
            makeVehicle(for: .active, type: .taxi)
        ]
        
        XCTAssertEqual(sut.map(taxis: list), expected)
    }
    
    func testMap_InactiveState() {
        let expected = [
            makeTaxiViewData(imageName: Constant.ImageName.inactive)
        ]
        let list = [
            makeVehicle(for: .inactive, type: .taxi)
        ]
        
        XCTAssertEqual(sut.map(taxis: list), expected)
    }
    
}

private extension TaxisMapperTests {
    
    enum Constant {
        enum ImageName: String {
            case active = "taxi-active"
            case inactive = "taxi-inactive"
        }
        
    }
    
    func makeVehicle(for state: Vehicle.State, type: Vehicle.`Type`) -> Vehicle {
        .init(id: -723528,
              state: state,
              type: type,
              heading:  281.30,
              coordinate: .init(latitude: 53.63, longitude: 10.00))
    }
    
    func makeTaxiViewData(imageName: Constant.ImageName) -> TaxiViewData {
        .init(image: UIImage(named: imageName.rawValue)!, text: "Taxi")
    }
    
    
}
