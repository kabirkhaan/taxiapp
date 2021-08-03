//
//  RootVehicles.swift
//  TaxiApp
//
//  Created by Kabir Khan on 20.12.20.
//

import Foundation

struct RootVehicles: Equatable {
    
    let vehicles: [Vehicle]
    
}

extension RootVehicles: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case root = "poiList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vehicles = try values.decode([Vehicle].self, forKey: .root)
    }
    
}
