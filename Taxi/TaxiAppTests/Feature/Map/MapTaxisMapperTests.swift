//
//  MapTaxisMapperTests.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import XCTest
@testable import TaxiApp

final class MapTaxisMapperTests: XCTestCase {
    
    private var sut: MapTaxisMapper!
    
    override func setUp() {
        super.setUp()
        sut = MapTaxisMapperImpl()
    }
    
    func testMap_ActiveState() {
        let expected = [
            makeTaxiAnnotationViewData(imageName: Constant.ImageName.active)
        ]
        let list = [
            makeVehicle(for: .active, type: .taxi)
        ]
        
        let result = sut.map(taxis: list)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first!.coordinate.latitude, expected.first!.coordinate.latitude)
        XCTAssertEqual(result.first!.coordinate.longitude, expected.first!.coordinate.longitude)
        XCTAssertNotNil(result.first!.image)
    }
    
    func testMap_InactiveState() {
        let expected = [
            makeTaxiAnnotationViewData(imageName: Constant.ImageName.inactive)
        ]
        let list = [
            makeVehicle(for: .inactive, type: .taxi)
        ]
        
        let result = sut.map(taxis: list)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first!.coordinate.latitude, expected.first!.coordinate.latitude)
        XCTAssertEqual(result.first!.coordinate.longitude, expected.first!.coordinate.longitude)
        XCTAssertNotNil(result.first!.image)
    }
    
}
private extension MapTaxisMapperTests {
    
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
    
    func makeTaxiAnnotationViewData(imageName: Constant.ImageName) -> TaxiAnnotationViewData {
        .init(coordinate: .init(latitude: 53.63, longitude: 10.00),
              image: UIImage(named: imageName.rawValue)!.resized(to: CGSize(width: 30, height: 30)))
    }
    
    
}
