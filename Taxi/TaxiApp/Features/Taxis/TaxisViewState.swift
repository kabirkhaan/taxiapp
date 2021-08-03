//
//  TaxisViewState.swift
//  TaxiApp
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation

enum TaxisViewState {
    case changeFilter(Int)
    case loading
    case updated
    case error(message: String)
}
