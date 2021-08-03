//
//  MapTaxisFetchUseCase.swift
//  TaxiApp
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation

protocol MapTaxisFetchUseCase: class {
    
    typealias Response = (Result<([TaxiAnnotationViewData]), Error>) -> Void
    var onExecuted: Response? { get set }
    func execute(start: Coordinate, destination: Coordinate)
}

final class MapTaxisFetchUseCaseImpl: MapTaxisFetchUseCase {
    
    let mapper: MapTaxisMapper
    let repository: TaxisRepository
    var onExecuted: Response?
    
    init(mapper: MapTaxisMapper, repository: TaxisRepository) {
        self.mapper = mapper
        self.repository = repository
    }
    
    func execute(start: Coordinate, destination: Coordinate) {
        repository.getAll(start: start,
                          destination: destination) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let taxis):
                self.onExecuted?(.success((self.mapper.map(taxis: taxis))))
            case .failure(let error):
                self.onExecuted?(.failure(error))
            }
        }
        
    }
    
}
