//
//  TaxisRemoteRepository.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation

protocol TaxisRemoteRepository {
    
    func getAll(start: Coordinate,
             destination: Coordinate,
             completion: @escaping (Result<RootVehicles, Error>) -> Void)
}

struct TaxisRemoteRepositoryImpl: TaxisRemoteRepository {
    
    let service: NetworkService
    
    func getAll(start: Coordinate,
             destination: Coordinate,
             completion: @escaping (Result<RootVehicles, Error>) -> Void) {
        let request = TaxisRequest(start: start, destination: destination)
        service.perform(request: request, completion: completion)
    }
    
}
