//
//  MockTaxisMapper.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
import UIKit
@testable import TaxiApp

final class MockTaxisMapper: TaxisMapper {
    
    var taxis:  [Vehicle]?
    
    func map(taxis: [Vehicle]) -> [TaxiViewData] {
        self.taxis = taxis
        
        return [
            .init(image: UIImage(named: "taxi-active")!, text: "Active")
        ]
    }
    
    
}
