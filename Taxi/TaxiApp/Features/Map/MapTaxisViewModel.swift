//
//  MapTaxisViewModel.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation

protocol MapTaxisViewModel: class {
    
    var onStateChange: ((MapTaxisViewState) -> Void)? { get set }
    func refresh()
}

final class MapTaxisViewModelImpl: MapTaxisViewModel {
    
    let useCase: MapTaxisFetchUseCase
    var onStateChange: ((MapTaxisViewState) -> Void)?
    private let start = Coordinate(latitude: 53.694865, longitude: 9.757589)
    private let destination = Coordinate(latitude: 53.394655, longitude: 10.099891)
    
    init(useCase: MapTaxisFetchUseCase) {
        self.useCase = useCase
        registerUseCaseEvents()
    }
    
    func refresh() {
        update(state: .loading)
        useCase.execute(start: start, destination: destination)
    }

}

private extension MapTaxisViewModelImpl {
    
    func registerUseCaseEvents() {
        useCase.onExecuted = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let annotations):
                self.update(state: .updated(list: annotations))
            case .failure(let error):
                self.update(state: .error(message: error.localizedDescription))
            }
        }
    }
    
    func update(state: MapTaxisViewState) {
        DispatchQueue.main.async {
            self.onStateChange?(state)
        }
    }
    
}
