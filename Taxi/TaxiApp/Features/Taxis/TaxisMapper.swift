//
//  TaxisMapper.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
import UIKit

protocol TaxisMapper {
    
    func map(taxis: [Vehicle]) -> [TaxiViewData]
}

struct TaxisMapperImpl: TaxisMapper {
    
    func map(taxis: [Vehicle]) -> [TaxiViewData] {
        return taxis.compactMap( {
            let imageName = $0.state == .active ? "taxi-active" : "taxi-inactive"
            let image = UIImage(named: imageName)!
            
            return TaxiViewData(image: image, text: $0.type.rawValue.localizedCapitalized)
        })
    }
    
}
