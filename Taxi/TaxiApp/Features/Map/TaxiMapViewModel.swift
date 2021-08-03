//
//  TaxiMapViewModel.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
protocol TaxisMapViewModel {
    
    func refresh()
}

final class TaxisMapViewModelImpl: TaxisMapViewModel {
    
    let useCase: TaxisFetchUseCase
    
    init(useCase: TaxisFetchUseCase) {
        self.useCase = useCase
        registerUseCase()
    }
    
    func refresh() {
        let start = Coordinate(latitude: 12.2, longitude: 1212.2, heading: 0)
        let destination = Coordinate(latitude: 12.2, longitude: 1212.2, heading: 0)
        useCase.execute(startLocation: start, destination: destination)
    }
}

private extension TaxisMapViewModelImpl {
    
    func registerUseCase() {
//        useCase.onExecuted = { [weak self] result in
//            switch result {
//            case .success():
//                <#code#>
//            default:
//                <#code#>
//            }
//        }
    }
}
