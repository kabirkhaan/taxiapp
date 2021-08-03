//
//  MockTaxisRepository.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 21.12.20.
//

import Foundation
@testable import TaxiApp

final class MockTaxisRepository: TaxisRepository {
    
    var success = true
    
    func getAll(start: Coordinate,
                destination: Coordinate,
                completion: @escaping (Result<[Vehicle], Error>) -> Void) {
        guard success else {
            completion(.failure(Mocker.StubError.fake))
            return
        }
        
        let vehicles: [Vehicle] =
            [
                .init(id: -723528,
                      state: .active,
                      type: .taxi,
                      heading:  281.30,
                      coordinate: .init(latitude: 53.63, longitude: 10.00)),
                .init(id: 1884800943,
                      state: .inactive,
                      type: .taxi,
                      heading:  149.06,
                      coordinate: .init(latitude: 53.54, longitude: 10.10))
            ]
        
        completion(.success(vehicles))
    }
    
}
