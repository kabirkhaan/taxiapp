//
//  TaxiAnnotationViewData.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
import MapKit

final class TaxiAnnotationViewData: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let image: UIImage

    init(coordinate: CLLocationCoordinate2D, image: UIImage) {
        self.coordinate = coordinate
        self.image = image
    }
    
}
