//
//  TaxisRequest.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation

struct TaxisRequest {
    
    let start: Coordinate
    let destination: Coordinate
    
    private let baseUrl = "https://poi-api.mytaxi.com"
}

extension TaxisRequest: NetworkRequestConvertible {
    
    var method: RequestHTTPMethod { .get }
    var url: URL {
        URL(string: "\(baseUrl)/PoiService/poi/v1" )!
    }
    var parameters: RequestParameters {
        [
            "p1Lat": "\(start.latitude)",
            "p1Lon": "\(start.longitude)",
            "p2Lat": "\(destination.latitude)",
            "p2Lon": "\(destination.longitude)",
        ]
    }
    
}

