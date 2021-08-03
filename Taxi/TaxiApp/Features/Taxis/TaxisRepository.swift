//
//  TaxisRepository.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation

protocol TaxisRepository {
    
    func getAll(start: Coordinate,
                destination: Coordinate,
                completion: @escaping (Result<[Vehicle], Error>) -> Void)
}

struct TaxisRepositoryImpl: TaxisRepository {
    
    let remoteRepository: TaxisRemoteRepository
    
    func getAll(start: Coordinate,
                destination: Coordinate,
                completion: @escaping (Result<[Vehicle], Error>) -> Void)  {
        remoteRepository.getAll(start: start,
                                destination: destination) { result in
            switch result {
            case .success(let root):
                completion(.success(root.vehicles))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
}
