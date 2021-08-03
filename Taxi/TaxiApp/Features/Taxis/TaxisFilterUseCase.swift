//
//  TaxisFilterUseCase.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation

protocol TaxisFilterUseCase {
    
    func execute(list: [Vehicle], filter: TaxiViewFilter) -> [TaxiViewData]
}

struct TaxisFilterUseCaseImpl: TaxisFilterUseCase {
    
    let mapper: TaxisMapper
    
    func execute(list: [Vehicle], filter: TaxiViewFilter) -> [TaxiViewData] {
        return mapper.map(taxis: apply(filter: filter, in: list))
    }
    
}

extension TaxisFilterUseCaseImpl {
    
    func apply(filter: TaxiViewFilter, in list: [Vehicle]) -> [Vehicle] {
        switch filter {
        case .active:
            return list.filter({ $0.state == .active})
        case .inactive:
            return list.filter({ $0.state == .inactive})
        case .all:
            return list
        }
    }
}
