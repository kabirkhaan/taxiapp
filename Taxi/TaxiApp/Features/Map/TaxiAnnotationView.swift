//
//  TaxiAnnotationView.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
import MapKit

final class TaxiAnnotationView: MKAnnotationView {
    
    func configure(with viewData: TaxiAnnotationViewData) {
        self.annotation = viewData
        self.image = viewData.image
    }
    
}
