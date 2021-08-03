//
//  TaxisFetchUseCase.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation

protocol TaxisFetchUseCase: class {
    
    typealias Response = (Result<([Vehicle], [TaxiViewData]), Error>) -> Void
    var onExecuted: Response? { get set }
    func execute(start: Coordinate, destination: Coordinate)
}

final class TaxisFetchUseCaseImpl: TaxisFetchUseCase {
    
    let mapper: TaxisMapper
    let repository: TaxisRepository
    var onExecuted: Response?
    
    init(mapper: TaxisMapper, repository: TaxisRepository) {
        self.mapper = mapper
        self.repository = repository
    }
    
    func execute(start: Coordinate, destination: Coordinate) {
        repository.getAll(start: start,
                          destination: destination) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let taxis):
                self.onExecuted?(.success((taxis, self.mapper.map(taxis: taxis))))
            case .failure(let error):
                self.onExecuted?(.failure(error))
            }
        }
        
    }
    
}
