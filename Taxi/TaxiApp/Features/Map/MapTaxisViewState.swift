//
//  MapTaxisViewState.swift
//  TaxiApp
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation
import MapKit

enum MapTaxisViewState {
    case loading
    case updated(list: [MKAnnotation])
    case error(message: String)
}
