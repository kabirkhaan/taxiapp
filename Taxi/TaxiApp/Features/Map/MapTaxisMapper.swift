//
//  MapTaxisMapper.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
import UIKit
import CoreLocation

protocol MapTaxisMapper {
    
    func map(taxis: [Vehicle]) -> [TaxiAnnotationViewData]
}

struct MapTaxisMapperImpl: MapTaxisMapper {
    
    func map(taxis: [Vehicle]) -> [TaxiAnnotationViewData] {
        return taxis.compactMap({
                                    let imageName = $0.state == .active ? "taxi-active" : "taxi-inactive"
                                    let image = UIImage(named: imageName)!.resized(to: Constant.imageSize)
                                    let coordinate = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
                                    return TaxiAnnotationViewData(coordinate: coordinate,  image: image) })
    }
    
}

private extension MapTaxisMapperImpl {
    
    enum Constant {
        static let imageSize = CGSize(width: 30, height: 30)
    }
}
