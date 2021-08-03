//
//  Vehicle.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation

struct Vehicle: Decodable, Equatable {
    
    enum State: String, Decodable {
        case active = "ACTIVE",
             inactive = "INACTIVE"
    }
    
    enum `Type`: String, Decodable {
        case taxi = "TAXI"
    }
    
    let id: Int64
    let state: State
    let type: Type
    let heading: Double
    let coordinate : Coordinate
    
}
